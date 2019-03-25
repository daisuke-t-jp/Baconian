//
//  main.swift
//  SysInfoTester-macOSCommandLine
//
//  Created by Daisuke T on 2019/03/19.
//  Copyright © 2019 SysInfoTester-macOSCommandLine. All rights reserved.
//

import Foundation

class Delegate: ReporterDelegate {
	public var data = Reporter.Data()
	
	func reporter(_ manager: Reporter, didUpdate data: Reporter.Data) {
		self.data = data
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


let delegate = Delegate()
let reporter = Reporter()
var memoryMap = [Date: [UInt8]]()
var threadMap = [Data: [Thread]]()

let commandTypeStart = "-start"
let commandTypeStop = "-stop"
let commandTypeEnableDelegate = "-enableDelegate"
let commandTypeDisableDelegate = "-disableDelegate"
let commandTypeData = "-data"
let commandTypeTest = "-test"
let commandValueTestMemoryAlloc = "memoryalloc"
let commandValueTestThreadCreate = "threadcreate"
let commandValueTestMemoryDealloc = "memorydealloc"
let commandValueTestThreadDestroy = "threaddestroy"
// Commands:
// -start				start report.
// -stop				stop report.
// -enableDelegate		delegate switch to enable.
// -disableDelegate		delegate switch to disable.
// -data				show last update data.
// TODO: test command
// -test memoryallo		allocate test memory.
// -test threadcreate	create test thread.
// -test memorydealloc	deallocate test memory.
// -test threaddestroy	destroy test thread.
while(true) {
	
	autoreleasepool {
		var inputStr = String(data: FileHandle.standardInput.availableData,
							  encoding: String.Encoding.utf8) ?? ""
		inputStr = inputStr.trimmingCharacters(in: NSCharacterSet.newlines)
		let array = inputStr.components(separatedBy: " ")
		guard array.count > 0 else {
			return
		}
		
		if array[0].lowercased() == commandTypeStart {
			print("start")
			reporter.start()
		} else if array[0].lowercased() == commandTypeStop {
			print("stop")
			reporter.stop()
		} else if array[0].lowercased() == commandTypeDisableDelegate {
			print("delegate enable")
			reporter.delegate = delegate
		} else if array[0].lowercased() == commandTypeEnableDelegate {
			print("delegate disable")
			reporter.delegate = nil
		} else if array[0].lowercased() == commandTypeData {
			print("data")
			print(delegate.data)
		}
		
		if array[0].lowercased() == commandTypeTest {
			guard array.count > 2 else {
				return
			}
			
			if array[1].lowercased() == commandValueTestMemoryAlloc {
				print("memory alloc")
				memoryMap[Date()] = [UInt8](repeating: 255, count: 1024 * 1024 * 32)
			} else if array[1].lowercased() == commandValueTestMemoryDealloc {
				print("memory dealloc")
				memoryMap = [Date: [UInt8]]()
			} else if array[1].lowercased() == commandValueTestThreadCreate {
				print("thread create")
			} else if array[1].lowercased() == commandValueTestThreadDestroy {
				print("thread destroy")
			}
		}
	}
	
}
