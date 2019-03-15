//
//  ThreadInfo.swift
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
	
	struct ThreadInfo {
		var userTime = TimeInterval(0)		// user run time
		var systemTime = TimeInterval(0)	// system run time
		var cpuUsage = Int(0)				// scaled cpu usage percentage
		var policy = Int(0)					// scheduling policy in effect
		var runState = ThreadState.stopped	// run state
		var flags = ThreadFlag.idle			// various flags
		var suspendCount = Int(0)			// suspend count for thread
		var sleepTime = TimeInterval(0)		// number of seconds that thread has been sleeping
	}
	
	
	static func threadInfoArray() -> [ThreadInfo] {
		var list = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
		var count = UInt32(MemoryLayout<mach_task_basic_info_data_t>.stride / MemoryLayout<natural_t>.stride)
		
		_ = withUnsafeMutablePointer(to: &list) {
			$0.withMemoryRebound(to: thread_act_array_t?.self, capacity: 1) {
				task_threads(mach_task_self_, $0, &count)
			}
		}
		
		var threadInfoArray = [ThreadInfo]()
		var machThreadInfo = thread_basic_info()
		for i in 0..<count {
			var infoCount = UInt32(THREAD_INFO_MAX)
			
			_ = withUnsafeMutablePointer(to: &machThreadInfo) {
				$0.withMemoryRebound(to: integer_t.self, capacity: 1) {
					thread_info(list[Int(i)], UInt32(THREAD_BASIC_INFO), $0, &infoCount)
				}
			}
			
			var threadInfo = ThreadInfo()
			threadInfo.userTime = TimeInterval(machThreadInfo.user_time)
			threadInfo.systemTime = TimeInterval(machThreadInfo.system_time)
			threadInfo.cpuUsage = Int(machThreadInfo.cpu_usage)
			threadInfo.policy = Int(machThreadInfo.policy)
			threadInfo.runState = machThreadInfo.run_state
			threadInfo.flags = ThreadFlag(rawValue: machThreadInfo.flags)
			threadInfo.suspendCount = Int(machThreadInfo.suspend_count)
			threadInfo.sleepTime = TimeInterval(machThreadInfo.sleep_time)
			
			threadInfoArray.append(threadInfo)
		}
		
		return threadInfoArray
	}
	
	static func threadInfoIsIdle(_ threadInfo: ThreadInfo) -> Bool {
		if threadInfo.flags.contains(ThreadFlag.idle) {
			return true
		}
		
		if threadInfo.flags.contains(ThreadFlag.globalForcedIdle) {
			return true
		}
		
		return false
	}
	
}
