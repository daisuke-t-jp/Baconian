//
//  main.swift
//  SysInfoTester-macOSCommandLine
//
//  Created by Daisuke T on 2019/03/19.
//  Copyright © 2019 SysInfoTester-macOSCommandLine. All rights reserved.
//

import Foundation

let tester = Tester()

let commandTypeStart = "-start"
let commandTypeStop = "-stop"
let commandTypeDelegateEnable = "-delegateEnable"
let commandTypeDelegateDisable = "-delegateDisable"
let commandTypeData = "-data"
let commandTypeTest = "-test"
let commandValueTestMemoryAlloc = "memoryAlloc"
let commandValueTestMemoryDealloc = "memoryDealloc"
let commandValueTestThreadCreate = "threadCreate"
let commandValueTestThreadDestroy = "threadDestroy"
// Commands:
// -start				start report.
// -stop				stop report.
// -delegateEnable		delegate switch to enable.
// -delegateDisable		delegate switch to disable.
// -data				show last update data.
// -test memoryAlloc	allocate test memory.
// -test memoryDealloc	deallocate test memory.
// -test threadCreate	create test thread.
// -test threadDestroy	destroy test thread.
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
			print("Reporter start")
			tester.reporterStart()
		} else if array[0].lowercased() == commandTypeStop.lowercased() {
			print("Reporter stop")
			tester.reporterStop()
		} else if array[0].lowercased() == commandTypeDelegateEnable.lowercased() {
			print("Delegate enable")
			tester.reporterDelegateEnable()
		} else if array[0].lowercased() == commandTypeDelegateDisable.lowercased() {
			print("Delegate disable")
			tester.reporterDelegateDisable()
		} else if array[0].lowercased() == commandTypeData.lowercased() {
			print("Data")
			print("# OS")
			print("## Memory")
			print(tester.data.osMemory)
			print("## CPU")
			print(tester.data.osCPU)
			print("## Processors")
			print(tester.data.osProcessors)
			print("# Process")
			print("## Memory")
			print(tester.data.processMemory)
			print("## CPU")
			print(tester.data.processCPU)
			print("## Thread")
			print(tester.data.processThread)
		}
		
		if array[0].lowercased() == commandTypeTest.lowercased() {
			guard array.count >= 2 else {
				return
			}
			
			if array[1].lowercased() == commandValueTestMemoryAlloc.lowercased() {
				print("Memory alloc")
				tester.memoryAlloc(1024 * 1024 * 32)
			} else if array[1].lowercased() == commandValueTestMemoryDealloc.lowercased() {
				print("Memory dealloc")
				tester.memoryDealloc()
			} else if array[1].lowercased() == commandValueTestThreadCreate.lowercased() {
				print("Thread create")
				tester.threadCreate(1024 * 32, sleepInterval: 0.01)
			} else if array[1].lowercased() == commandValueTestThreadDestroy.lowercased() {
				print("Thread destroy")
				tester.threadDestroy()
			}
		}
	}
	
}
