//
//  MachHostProcessorInfo.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Mach {
	
	static func hostProcessorInfo() -> [CPUTick] {
		
		var cpuCount: natural_t = 0
		var cpuInfoArray: processor_info_array_t? = nil
		var cpuInfoCount: mach_msg_type_number_t = 0
		guard KERN_SUCCESS == host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &cpuCount, &cpuInfoArray, &cpuInfoCount) else {
			return [CPUTick]()
		}
		
		do {
			guard cpuCount > 0 else {
				return [CPUTick]()
			}
			guard let cpuInfoArray = cpuInfoArray else {
				return [CPUTick]()
			}
			defer {
				vm_deallocate(mach_task_self_, vm_address_t(bitPattern: cpuInfoArray), vm_size_t(cpuInfoCount))
			}
			
			var array = [CPUTick]()
			for i in 0..<cpuCount {
				var tick = CPUTick()
				let index = Int32(i) * CPU_STATE_MAX
				tick.userTick = UInt32(cpuInfoArray[Int(index + CPU_STATE_USER)])
				tick.systemTick = UInt32(cpuInfoArray[Int(index + CPU_STATE_SYSTEM)])
				tick.idleTick = UInt32(cpuInfoArray[Int(index + CPU_STATE_IDLE)])
				tick.niceTick = UInt32(cpuInfoArray[Int(index + CPU_STATE_NICE)])
				
				array.append(tick)
			}
			
			return array
		}
	}
}
