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
		let userUsage: Float
		let systemUsage: Float
		let idleUsage: Float
		
		public var description: String {
			return String(format: "user: %.2f%%, system: %.2f%%, idle: %.2f%%",
						  userUsage * 100,
						  systemUsage * 100,
						  idleUsage * 100
			)
		}
		
	}
	
}


extension Report.OS.CPU {
	
	init() {
		userUsage = 0
		systemUsage = 0
		idleUsage = 0
	}
	
	init(_ data: Mach.CPUTick, prevData: Mach.CPUTick) {
		// Caluculation tick's diff.
		let user = Float(data.userTick - prevData.userTick)
		let system = Float(data.systemTick - prevData.systemTick)
		let idle = Float(data.idleTick - prevData.idleTick)
		
		// TODO: nice
		// let nice = Float(data.niceTick - prevData.niceTick)
		
		
		// Caluculation CPU usage
		let total = user + system + idle /* + nice */
		if total == 0 {
			userUsage = 0
			systemUsage = 0
			idleUsage = 0
		} else {
			userUsage = user / total
			systemUsage = system / total
			idleUsage = idle / total
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
