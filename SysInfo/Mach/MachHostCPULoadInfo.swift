//
//  MachHostCPULoadInfo.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Mach {
	
	static func hostCPULoadInfo() -> CPUTick {
		var machData = host_cpu_load_info()
		var count = mach_msg_type_number_t(MemoryLayout<host_cpu_load_info>.stride / MemoryLayout<integer_t>.stride)
		
		let machRes = withUnsafeMutablePointer(to: &machData) {
			$0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
				host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &count)
			}
		}
		
		guard machRes == KERN_SUCCESS else {
			return CPUTick()
		}
		
		
		var res = CPUTick()
		res.userTick = UInt32(machData.cpu_ticks.0)		// CPU_STATE_USER
		res.systemTick = UInt32(machData.cpu_ticks.1)	// CPU_STATE_SYSTEM
		res.idleTick = UInt32(machData.cpu_ticks.2)		// CPU_STATE_IDLE
		res.niceTick = UInt32(machData.cpu_ticks.3)		// CPU_STATE_NICE
		
		return res
	}
}
