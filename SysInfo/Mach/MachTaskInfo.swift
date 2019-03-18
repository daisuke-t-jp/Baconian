//
//  TaskInfo.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Mach {
	
	struct TaskInfo {
		public var virtualSize = UInt64(0)
		public var residentSize = UInt64(0)
		public var residentSizeMax = UInt64(0)
		public var userTime = TimeInterval(0)
		public var systemTime = TimeInterval(0)
		public var policy = Int(0)
		public var suspendCount = Int(0)
	}
	
	static func taskInfo() -> TaskInfo {
		var machTaskInfo = mach_task_basic_info()
		var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.stride / MemoryLayout<integer_t>.stride)
		
		_ = withUnsafeMutablePointer(to: &machTaskInfo) {
			task_info(mach_task_self_,
					  task_flavor_t(MACH_TASK_BASIC_INFO),
					  $0.withMemoryRebound(to: Int32.self, capacity: 1) { pointer in
						UnsafeMutablePointer<Int32>(pointer)
			}, &count)
		}
		
		var taskInfo = TaskInfo()
		taskInfo.virtualSize = machTaskInfo.virtual_size
		taskInfo.residentSize = machTaskInfo.resident_size
		taskInfo.residentSizeMax = machTaskInfo.resident_size_max
		taskInfo.userTime = TimeInterval(machTaskInfo.user_time)
		taskInfo.systemTime = TimeInterval(machTaskInfo.system_time)
		taskInfo.policy = Int(machTaskInfo.policy)
		taskInfo.suspendCount = Int(machTaskInfo.suspend_count)

		return taskInfo
	}
}

