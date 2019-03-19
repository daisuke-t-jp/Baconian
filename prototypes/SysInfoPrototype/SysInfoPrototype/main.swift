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
		// Host
		print("HostVMStatics[\(Mach.hostVMStatics())]")
		print("HostCPULoadInfo[\(Mach.hostCPULoadInfo())]")
		print("HostProcessorInfo[\(Mach.hostProcessorInfo())]")
		print("")

		// Task
		print("TaskBasicInfo[\(Mach.taskBasicInfo())]")
		print("TaskThreadBasicInfo[\(Mach.taskThreadBasicInfo())]")

		Thread.sleep(forTimeInterval: 1)
	}
}
