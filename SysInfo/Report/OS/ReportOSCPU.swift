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
			return String(format: "user[%.2f%%] system[%.2f%%] idle[%.2f%%]",
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
	
}


extension Report.OS {

	static func cpu() -> CPU {
		let machData = Mach.Host.cpuLoadInfo()
		
		// Caluculation tick's diff.
		let user = Float(machData.userTick - lastCPUTick.userTick)
		let system = Float(machData.systemTick - lastCPUTick.systemTick)
		let idle = Float(machData.idleTick - lastCPUTick.idleTick)
		// TODO: nice
		// let nice = Float(machData.niceTick - lastCPUTick.niceTick)
		let total = user + system + idle /* + nice */
		guard total != 0 else {
			return CPU()
		}
		
		
		// Store last cpu tick
		lastCPUTick = machData
		
		
		// Caluculation CPU usage
		let res = CPU(
			userUsage: user / total,
			systemUsage: system / total,
			idleUsage: idle / total
		)
		
		return res
	}
	
}
