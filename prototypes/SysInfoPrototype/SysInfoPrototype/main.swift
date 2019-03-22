//
//  main.swift
//  SysInfoPrototype
//
//  Created by Daisuke T on 2019/03/19.
//  Copyright © 2019 SysInfoPrototype. All rights reserved.
//

import Foundation

class Dummy: ReporterDelegate {
	func reporter(_ manager: Reporter, didUpdate data: Reporter.Data) {
		print("# Reporter")
		print("- \(Date())")
		print("- \(data)")
		print("----------")
	}
}


func testImmediate() {
	print("# Immediate")
	print("- \(Date())")
	print("")
	
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
	print("----------")
}


let enableImmediate = false
let dummy = Dummy()
let reporter = Reporter()

if !enableImmediate {
	reporter.delegate = dummy
	reporter.start()
}


while(true) {
	
	autoreleasepool {
		
		if enableImmediate {
			testImmediate()
		
		}
		
		Thread.sleep(forTimeInterval: 1)

	}
	
}
