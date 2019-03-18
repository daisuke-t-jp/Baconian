//
//  ProcessMemoryInfo.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension SysInfoReporter {
	
	public struct ProcessMemoryInfo {
		public var residentSize = UInt64(0)
		public var residentSizeMax = UInt64(0)
	}
	
	static func processMemoryInfo() -> ProcessMemoryInfo {
		let taskInfo = Mach.taskInfo()
		
		var processMemoryInfo = ProcessMemoryInfo()
		processMemoryInfo.residentSize = taskInfo.residentSize
		processMemoryInfo.residentSizeMax = taskInfo.residentSizeMax
		
		return processMemoryInfo
	}
	
}
