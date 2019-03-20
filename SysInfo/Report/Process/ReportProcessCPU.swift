//
//  ReportProcessCPU.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Report.Process {
	
	public struct CPU: CustomStringConvertible {
		let usage: Float
		let time: TimeInterval
		
		public var description: String {
			return String(format: "usage[%.2f%%] time[%fs]",
						  usage,
						  time
			)
		}
	}
}


extension Report.Process.CPU {
	
	init() {
		usage = 0
		time = 0
	}
	
}


extension Report.Process {
	
	static func cpu() -> CPU {
		let array = Mach.Task.threadBasicInfo()
		
		var usage = Float(0)
		var time = TimeInterval(0)
		
		for thread in array {
			guard !Mach.Task.threadBasicInfoIsIdle(thread) else {
				continue
			}
			
			usage += (Float(thread.cpuUsage) / Float(TH_USAGE_SCALE)) * 100.0
			time += thread.userTime
			time += thread.systemTime
		}
		
		let res = CPU(usage: usage, time: time)
		
		return res
	}
	
}
