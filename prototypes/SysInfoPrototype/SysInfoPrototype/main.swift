//
//  main.swift
//  SysInfoPrototype
//
//  Created by Daisuke T on 2019/03/19.
//  Copyright © 2019 SysInfoPrototype. All rights reserved.
//

import Foundation

while(true) {
	autoreleasepool {
		print("# Test")
		print("- \(Date())")
		print("")

		do {
			print("## Mach")
			
			print("### Host")
			print("#### VMStatics")
			print("- \(Mach.Host.vmStatics())")
			print("#### CPULoadInfo")
			print("- \(Mach.Host.cpuLoadInfo())")
			print("#### ProcessorInfo")
			print("- \(Mach.Host.processorInfo())")
			print("")
			
			print("### Task")
			print("#### BasicInfo")
			print("- \(Mach.Task.basicInfo())")
			print("#### ThreadBasicInfo")
			print("- \(Mach.Task.threadBasicInfo())")
			print("")
		}
		
		do {
			print("## Report")
			
			print("### OS")
			print("#### Memory")
			print("- \(Report.OS.memory())")
			print("#### CPU")
			print("- \(Report.OS.cpu())")
			print("#### Processors")
			print("- \(Report.OS.processors())")
			print("")
			
			print("### Process")
			print("#### Memory")
			print("- \(Report.Process.memory())")
			print("#### CPU")
			print("- \(Report.Process.cpu())")
			print("#### Thread")
			print("- \(Report.Process.thread())")
			print("")
		}
		
		print("----------")
		
		Thread.sleep(forTimeInterval: 1)
	}
}
