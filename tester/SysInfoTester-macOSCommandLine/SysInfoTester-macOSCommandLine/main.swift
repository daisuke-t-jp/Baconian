//
//  main.swift
//  SysInfoTester-macOSCommandLine
//
//  Created by Daisuke T on 2019/03/19.
//  Copyright © 2019 SysInfoTester-macOSCommandLine. All rights reserved.
//

import Foundation

class Object: ReporterDelegate {
	public var data = Reporter.Data()
	
	func reporter(_ manager: Reporter, didUpdate data: Reporter.Data) {
		self.data = data
	}
	
	@objc func threadFunc() {
		while(true) {
			autoreleasepool {
				let array = [UInt8](repeating: 255, count: 1024 * 32)
				var data = Data()
				for byte in array {
					data.append(byte)
				}
				
				if Thread.current.isCancelled {
					print("Thread exit.")
					Thread.exit()
				}
				
				Thread.sleep(forTimeInterval: 0.001)
			}
		}
	}
}


let object = Object()
let reporter = Reporter()
reporter.delegate = object
reporter.start()

var memoryMap = [Date: [UInt8]]()
var threadMap = [Date: Thread]()

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
		
		if array[0].lowercased() == commandTypeStart.lowercased() {
			print("start")
			reporter.start()
		} else if array[0].lowercased() == commandTypeStop.lowercased() {
			print("stop")
			reporter.stop()
		} else if array[0].lowercased() == commandTypeEnableDelegate.lowercased() {
			print("enable delegate")
			reporter.delegate = object
		} else if array[0].lowercased() == commandTypeDisableDelegate.lowercased() {
			print("disable delegate")
			reporter.delegate = nil
		} else if array[0].lowercased() == commandTypeData.lowercased() {
			print("data")
			print("# OS")
			print("## Memory")
			print(object.data.osMemory)
			print("## CPU")
			print(object.data.osCPU)
			print("## Processors")
			print(object.data.osProcessors)
			print("# Process")
			print("## Memory")
			print(object.data.processMemory)
			print("## CPU")
			print(object.data.processCPU)
			print("## Thread")
			print(object.data.processThread)
		}
		
		if array[0].lowercased() == commandTypeTest.lowercased() {
			guard array.count >= 2 else {
				return
			}
			
			if array[1].lowercased() == commandValueTestMemoryAlloc.lowercased() {
				print("memory alloc")
				memoryMap[Date()] = [UInt8](repeating: 255, count: 1024 * 1024 * 32)
			} else if array[1].lowercased() == commandValueTestMemoryDealloc.lowercased() {
				print("memory dealloc")
				memoryMap = [Date: [UInt8]]()
			} else if array[1].lowercased() == commandValueTestThreadCreate.lowercased() {
				print("thread create")
				let thread = Thread(target: object,
									selector: #selector(object.threadFunc),
									object: nil)
				thread.start()
				threadMap[Date()] = thread
			} else if array[1].lowercased() == commandValueTestThreadDestroy.lowercased() {
				print("thread destroy")
				for thread in threadMap.values {
					thread.cancel()
				}
				threadMap = [Date: Thread]()
			}
		}
	}
	
}
