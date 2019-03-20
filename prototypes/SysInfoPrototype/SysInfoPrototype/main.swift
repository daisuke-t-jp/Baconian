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
			print("- HostVMStatics[\(Mach.hostVMStatics())]")
			print("- HostCPULoadInfo[\(Mach.hostCPULoadInfo())]")
			print("- HostProcessorInfo[\(Mach.hostProcessorInfo())]")
			print("")
			
			// Task
			print("## Task")
			print("- TaskBasicInfo[\(Mach.taskBasicInfo())]")
			print("- TaskThreadBasicInfo[\(Mach.taskThreadBasicInfo())]")
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
