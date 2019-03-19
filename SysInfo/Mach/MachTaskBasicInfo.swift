//
//  TaskBasicInfo.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Mach {
	
	struct TaskBasicInfo {
		public var virtualSize = UInt64(0)
		public var residentSize = UInt64(0)
		public var residentSizeMax = UInt64(0)
		public var userTime = TimeInterval(0)
		public var systemTime = TimeInterval(0)
		public var policy = Int(0)
		public var suspendCount = Int(0)
	}
	
	static func taskBasicInfo() -> TaskBasicInfo {
		var machData = mach_task_basic_info()
		var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.stride / MemoryLayout<integer_t>.stride)
		
		let machRes = withUnsafeMutablePointer(to: &machData) {
			task_info(mach_task_self_,
					  task_flavor_t(MACH_TASK_BASIC_INFO),
					  $0.withMemoryRebound(to: Int32.self, capacity: 1) { pointer in
						UnsafeMutablePointer<Int32>(pointer)
			}, &count)
		}
		
		guard machRes == KERN_SUCCESS else {
			return TaskBasicInfo()
		}
		
		var res = TaskBasicInfo()
		res.virtualSize = machData.virtual_size
		res.residentSize = machData.resident_size
		res.residentSizeMax = machData.resident_size_max
		res.userTime = TimeInterval(machData.user_time)
		res.systemTime = TimeInterval(machData.system_time)
		res.policy = Int(machData.policy)
		res.suspendCount = Int(machData.suspend_count)

		return res
	}
}

