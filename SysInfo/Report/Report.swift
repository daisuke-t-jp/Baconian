//
//  Report.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

final class Report {
	
	final class OS {
		static var machHostCPULoadInfoCache = Mach.CPUTick()
		static var machHostProcessorInfoCache = [Mach.CPUTick]()
	}
	
	final class Process {
	}
}
