//
//  ReportOSProcessors.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Report.OS {

	static func processors(_ machHostProcessorInfo: [Mach.CPUTick],
						   machHostProcessorInfoPrev: [Mach.CPUTick]) -> [CPU] {
		
		var res = [CPU]()
		for i in 0..<machHostProcessorInfo.count {
			let machData = machHostProcessorInfo[i]
			var prevData = Mach.CPUTick()
			
			if i < machHostProcessorInfoPrev.count {
				prevData = machHostProcessorInfoPrev[i]
			}
			
			let cpu = CPU(machData, prevData: prevData)
			res.append(cpu)
		}
		
		return res
	}
	
}
