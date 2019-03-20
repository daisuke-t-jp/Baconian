//
//  ReportOSCPU.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Report.OS {
	
	public struct CPU {
		public var userUsage = Float(0)
		public var systemUsage = Float(0)
		public var idleUsage = Float(0)
	}
	
	static func cpu() -> CPU {
		let machData = Mach.hostCPULoadInfo()
	
		// Caluculation tick's diff.
		let user = Float(machData.userTick - lastCPUTick.userTick)
		let system = Float(machData.systemTick - lastCPUTick.systemTick)
		let idle = Float(machData.idleTick - lastCPUTick.idleTick)
		// TODO: nice
		// let nice = Float(machData.niceTick - lastCPUTick.niceTick)
		let total = user + system + idle /* + nice */

		// Caluculation CPU usage
		var res = CPU()
		res.userUsage = user / total
		res.systemUsage = system / total
		res.idleUsage = idle / total
		
		// Store last cpu tick
		lastCPUTick = machData
		
		return res
	}
	
}
