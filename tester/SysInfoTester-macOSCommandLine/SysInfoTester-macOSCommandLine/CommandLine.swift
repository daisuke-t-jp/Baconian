//
//  CommandLine.swift
//  SysInfoTester-macOSCommandLine
//
//  Created by Daisuke T on 2019/03/25.
//  Copyright © 2019 SysInfoTester-macOSCommandLine. All rights reserved.
//

import Foundation

// Commands:
// -reporter start				start report.
// -reporter stop				stop report.
// -reporter delegateEnable		delegate switch to enable.
// -reporter delegateDisable	delegate switch to disable.
// -reporter frequency [normally|often|veryoften]	set frequency.
// -reporter data				show last update data.
// -test memoryAlloc			allocate test memory.
// -test memoryDealloc			deallocate test memory.
// -test threadCreate			create test thread.
// -test threadDestroy			destroy test thread.
class CommandLine {
	
	// MARk: Enum, Const
	private static let commandTypeReporter = "-reporter"
	private static let commandTypeTest = "-test"

	private static let commandValueReporterStart = "start"
	private static let commandValueReporterStop = "stop"
	private static let commandValueReporterDelegateEnable = "delegateEnable"
	private static let commandValueReporterDelegateDisable = "delegateDisable"
	private static let commandValueReporterFrequency = "frequency"
	private static let commandValueReporterData = "data"
	
	private static let commandValueReporterFrequencyNormally = "normally"
	private static let commandValueReporterFrequencyOften = "often"
	private static let commandValueReporterFrequencyVeryOften = "veryOften"
	
	private static let commandValueTestMemoryAlloc = "memoryAlloc"
	private static let commandValueTestMemoryDealloc = "memoryDealloc"
	private static let commandValueTestThreadCreate = "threadCreate"
	private static let commandValueTestThreadDestroy = "threadDestroy"
	
	
	// MARK: Property
	private let tester = Tester()

	
	func run(_ data: Data) {
		var str = String(data: data, encoding: .utf8) ?? ""
		str = str.trimmingCharacters(in: NSCharacterSet.newlines)
		let array = str.components(separatedBy: " ")
		guard array.count > 0 else {
			return
		}
		
		let command = array[0].lowercased()
		if command == CommandLine.commandTypeReporter.lowercased() {
			commandReporter(array)
			return
		} else if command == CommandLine.commandTypeTest.lowercased() {
			commandTest(array)
			return
		}
	}
	
	
	// MARK: File Handle
	func writeStandardOutput(_ str: String) {
		let handle = FileHandle.standardOutput
		let data = "\(str)\n".data(using: .utf8) ?? Data()
		handle.write(data)
	}

	func writeStandardError(_ str: String) {
		let handle = FileHandle.standardError
		let data = "\(str)\n".data(using: .utf8) ?? Data()
		handle.write(data)
	}
	

	// MARK: Command Report
	func commandReporter(_ array: [String]) {	// swiftlint:disable:this cyclomatic_complexity
		guard array.count >= 2 else {
			return
		}
		
		let value = array[1].lowercased()
		if value == CommandLine.commandValueReporterStart.lowercased() {
			commandReporterStart()
		} else if value == CommandLine.commandValueReporterStop.lowercased() {
			commandReporterStop()
		} else if value == CommandLine.commandValueReporterDelegateEnable.lowercased() {
			commandReporterDelegateEnable()
		} else if value == CommandLine.commandValueReporterDelegateDisable.lowercased() {
			commandReporterDelegateDisable()
		} else if value == CommandLine.commandValueReporterFrequency.lowercased() {
			guard array.count >= 3 else {
				return
			}
			
			let value2 = array[2].lowercased()
			if value2 == CommandLine.commandValueReporterFrequencyNormally.lowercased() {
				commandReporterFrequency(.normally)
			} else if value2 == CommandLine.commandValueReporterFrequencyOften.lowercased() {
				commandReporterFrequency(.often)
			} else if value2 == CommandLine.commandValueReporterFrequencyVeryOften.lowercased() {
				commandReporterFrequency(.veryOften)
			}
		} else if value == CommandLine.commandValueReporterData.lowercased() {
			commandReporterData()
		}
	}
	
	func commandReporterStart() {
		writeStandardOutput("Reporter start")
		tester.reporterStart()
	}
	
	func commandReporterStop() {
		writeStandardOutput("Reporter stop")
		tester.reporterStop()
	}
	
	func commandReporterDelegateEnable() {
		writeStandardOutput("Delegate enable")
		tester.reporterDelegateEnable()
	}
	
	func commandReporterDelegateDisable() {
		writeStandardOutput("Delegate disable")
		tester.reporterDelegateDisable()
	}
	
	func commandReporterFrequency(_ frequency: Reporter.Frequency) {
		writeStandardOutput("Frequency \(frequency)")
		tester.reporterSetFrequency(frequency)
	}
	
	func commandReporterData() {
		writeStandardOutput("Data")
		writeStandardOutput("# OS")
		writeStandardOutput("## Memory")
		writeStandardOutput(tester.data.osMemory.description)
		writeStandardOutput("## CPU")
		writeStandardOutput(tester.data.osCPU.description)
		writeStandardOutput("## Processors")
		writeStandardOutput(tester.data.osProcessors.description)
		writeStandardOutput("# Process")
		writeStandardOutput("## Memory")
		writeStandardOutput(tester.data.processMemory.description)
		writeStandardOutput("## CPU")
		writeStandardOutput(tester.data.processCPU.description)
		writeStandardOutput("## Thread")
		writeStandardOutput(tester.data.processThread.description)
	}
	
	
	// MARK: Command Test
	func commandTest(_ array: [String]) {
		guard array.count >= 2 else {
			return
		}
		
		let value = array[1].lowercased()
		if value == CommandLine.commandValueTestMemoryAlloc.lowercased() {
			commandTestMemoryAlloc()
		} else if value == CommandLine.commandValueTestMemoryDealloc.lowercased() {
			commandTestMemoryDealloc()
		} else if value == CommandLine.commandValueTestThreadCreate.lowercased() {
			commandTestThreadCreate()
		} else if value == CommandLine.commandValueTestThreadDestroy.lowercased() {
			commandTestThreadDestroy()
		}
	}
	
	func commandTestMemoryAlloc() {
		writeStandardOutput("Memory alloc")
		tester.memoryAlloc(1024 * 1024 * 32)
	}

	func commandTestMemoryDealloc() {
		writeStandardOutput("Memory dealloc")
		tester.memoryDealloc()
	}
	
	func commandTestThreadCreate() {
		writeStandardOutput("Thread create")
		tester.threadCreate(1024 * 32, sleepInterval: 0.01)
	}
	
	func commandTestThreadDestroy() {
		writeStandardOutput("Thread destroy")
		tester.threadDestroy()
	}
}