//
//  Report.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

public class Report {
	
	public class OS {
		static var machHostCPULoadInfoCache = Mach.CPUTick()
		static var machHostProcessorInfoCache = [Mach.CPUTick]()
	}
	
	public class Process {
	}
	
}
