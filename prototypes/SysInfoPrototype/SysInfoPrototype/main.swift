//
//  main.swift
//  SysInfoPrototype
//
//  Created by Daisuke T on 2019/03/19.
//  Copyright © 2019 SysInfoPrototype. All rights reserved.
//

import Foundation

while(true)
{
	autoreleasepool {
		do {
			print("# Mach")
			
			// Host
			print("## Host")
			print("- HostVMStatics[\(Mach.Host.vmStatics())]")
			print("- HostCPULoadInfo[\(Mach.Host.cpuLoadInfo())]")
			print("- HostProcessorInfo[\(Mach.Host.processorInfo())]")
			print("")
			
			// Task
			print("## Task")
			print("- TaskBasicInfo[\(Mach.Task.basicInfo())]")
			print("- TaskThreadBasicInfo[\(Mach.Task.threadBasicInfo())]")
		}
		
		do {
			print("# Report")
			
			// OS
			print("## OS")
			print("### Memory")
			print("- \(Report.OS.memory())")
			print("")
			
			// OS
			print("## OS")
			print("### CPU")
			print("- \(Report.OS.cpu())")
		}
		
		Thread.sleep(forTimeInterval: 1)
	}
}
