//
//  MachTaskThreadBasicInfo.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Mach {
	
	struct ThreadState {
		static let running = TH_STATE_RUNNING	// thread is running normally
		static let stopped = TH_STATE_STOPPED	// thread is stopped
		static let waiting = TH_STATE_WAITING	// thread is waiting normally
		static let uninterruptible = TH_STATE_UNINTERRUPTIBLE	// thread is in an uninterruptible wait
		static let halted = TH_STATE_HALTED	 // thread is halted at a clean point
	}
	
	struct ThreadFlag: OptionSet {
		let rawValue: Int32
		static let swapped = ThreadFlag(rawValue: TH_FLAGS_SWAPPED)	// thread is swapped out
		static let idle = ThreadFlag(rawValue: TH_FLAGS_IDLE)		// thread is an idle thread
		static let globalForcedIdle = ThreadFlag(rawValue: TH_FLAGS_GLOBAL_FORCED_IDLE)	// thread performs global forced idle
	}
	
	struct TaskThreadBasicInfo {
		var userTime = TimeInterval(0)		// user run time
		var systemTime = TimeInterval(0)	// system run time
		var cpuUsage = Int(0)				// scaled cpu usage percentage
		var policy = Int(0)					// scheduling policy in effect
		var runState = ThreadState.stopped	// run state
		var flags = ThreadFlag.idle			// various flags
		var suspendCount = Int(0)			// suspend count for thread
		var sleepTime = TimeInterval(0)		// number of seconds that thread has been sleeping
	}
	
	
	static func taskThreadBasicInfo() -> [TaskThreadBasicInfo] {
		var actList: thread_act_array_t? = nil
		var actListCount: mach_msg_type_number_t = 0
		guard KERN_SUCCESS == task_threads(mach_task_self_, &actList, &actListCount) else {
			return [TaskThreadBasicInfo]()
		}
		
		do {
			guard actListCount > 0 else {
				return [TaskThreadBasicInfo]()
			}
			guard let actList = actList else {
				return [TaskThreadBasicInfo]()
			}
			defer {
				vm_deallocate(mach_task_self_, vm_address_t(bitPattern: actList), vm_size_t(actListCount))
			}
			
			
			var array = [TaskThreadBasicInfo]()
			for i in 0..<actListCount {
				var machData = thread_basic_info()
				var count = UInt32(THREAD_INFO_MAX)
				
				let machRes = withUnsafeMutablePointer(to: &machData) {
					$0.withMemoryRebound(to: integer_t.self, capacity: 1) {
						thread_info(actList[Int(i)], thread_flavor_t(THREAD_BASIC_INFO), $0, &count)
					}
				}
				guard machRes == KERN_SUCCESS else {
					return [TaskThreadBasicInfo]()
				}
				
				var threadBasicInfo = TaskThreadBasicInfo()
				threadBasicInfo.userTime = TimeInterval(machData.user_time)
				threadBasicInfo.systemTime = TimeInterval(machData.system_time)
				threadBasicInfo.cpuUsage = Int(machData.cpu_usage)
				threadBasicInfo.policy = Int(machData.policy)
				threadBasicInfo.runState = machData.run_state
				threadBasicInfo.flags = ThreadFlag(rawValue: machData.flags)
				threadBasicInfo.suspendCount = Int(machData.suspend_count)
				threadBasicInfo.sleepTime = TimeInterval(machData.sleep_time)
				
				array.append(threadBasicInfo)
			}
			
			return array
		}
	}
	
	static func taskThreadBasicInfoIsIdle(_ taskThreadBasicInfo: TaskThreadBasicInfo) -> Bool {
		if taskThreadBasicInfo.flags.contains(ThreadFlag.idle) {
			return true
		}
		
		if taskThreadBasicInfo.flags.contains(ThreadFlag.globalForcedIdle) {
			return true
		}
		
		return false
	}
	
}
