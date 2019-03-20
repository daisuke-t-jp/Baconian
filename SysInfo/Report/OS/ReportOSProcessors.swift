//
//  ReportOSProcessors.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Report.OS {

	static func processors() -> [CPU] {
		let machArray = Mach.Host.processorInfo()
		
		var res = [CPU]()
		for i in 0..<machArray.count {
			let machData = machArray[i]
			var cacheData = Mach.CPUTick()
			
			if i < machHostProcessorInfoCache.count {
				cacheData = machHostProcessorInfoCache[i]
			}
			
			let cpu = CPU(machData, prevData: cacheData)
			res.append(cpu)
		}
		
		// Caching data
		machHostProcessorInfoCache = machArray
		
		return res
	}
	
}
