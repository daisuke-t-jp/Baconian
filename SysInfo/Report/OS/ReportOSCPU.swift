//
//  ReportOSCPU.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Report.OS {
	
	public struct CPU: CustomStringConvertible {
		let userUsage: Float	/// 0...1
		let systemUsage: Float	/// 0...1
		let idleUsage: Float	/// 0...1
		let niceUsage: Float	/// 0...1
		
		/// A usage except idle(0...1)
		var usage: Float {
			return 1.0 - idleUsage
		}
		
		public var description: String {
			return String(format: "user: %.2f%%, system: %.2f%%, idle: %.2f%%, nice: %.2f%%",
						  userUsage * 100,
						  systemUsage * 100,
						  idleUsage * 100,
						  niceUsage * 100
			)
		}
		
	}
	
}


extension Report.OS.CPU {
	
	init() {
		userUsage = 0
		systemUsage = 0
		idleUsage = 0
		niceUsage = 0
	}
	
	init(_ data: Mach.CPUTick, prevData: Mach.CPUTick) {
		// Caluculation tick's diff.
		let user = Float(data.userTick - prevData.userTick)
		let system = Float(data.systemTick - prevData.systemTick)
		let idle = Float(data.idleTick - prevData.idleTick)
		let nice = Float(data.niceTick - prevData.niceTick)
		
		
		// Caluculation CPU usage
		let total = user + system + idle + nice
		if total == 0 {
			userUsage = 0
			systemUsage = 0
			idleUsage = 0
			niceUsage = 0
		} else {
			userUsage = user / total
			systemUsage = system / total
			idleUsage = idle / total
			niceUsage = nice / total
		}
	}
	
}


extension Report.OS {

	static func cpu() -> CPU {
		let machData = Mach.Host.cpuLoadInfo()
		
		let res = CPU(machData, prevData: machHostCPULoadInfoCache)
		
		// Caching data
		machHostCPULoadInfoCache = machData
		
		return res
	}
	
}
