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
class CommandLine: ReporterDelegate {
	
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
	private let reporter = Reporter()
	private let tester = Tester()
	private var data = Reporter.Data()

	init() {
		
	}
	
}


// MARK: Reporter Delegate
extension CommandLine {
	
	func reporter(_ manager: Reporter, didUpdate data: Reporter.Data) {
		self.data = data
	}
	
}


// MARK: Run
extension CommandLine {
	
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
	
}


// MARK: File Handle
extension CommandLine {
	
	private func writeStandardOutput(_ str: String) {
		let handle = FileHandle.standardOutput
		let data = "\(str)\n".data(using: .utf8) ?? Data()
		handle.write(data)
	}

	private func writeStandardError(_ str: String) {
		let handle = FileHandle.standardError
		let data = "\(str)\n".data(using: .utf8) ?? Data()
		handle.write(data)
	}
	
}
	

// MARK: Command Report
extension CommandLine {
	
	private func commandReporter(_ array: [String]) {	// swiftlint:disable:this cyclomatic_complexity
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
		reporter.start()
	}
	
	func commandReporterStop() {
		writeStandardOutput("Reporter stop")
		reporter.stop()
	}
	
	func commandReporterDelegateEnable() {
		writeStandardOutput("Delegate enable")
		reporter.delegate = self
	}
	
	func commandReporterDelegateDisable() {
		writeStandardOutput("Delegate disable")
		reporter.delegate = nil
	}
	
	func commandReporterFrequency(_ frequency: Reporter.Frequency) {
		writeStandardOutput("Frequency \(frequency)")
		reporter.frequency = frequency
	}
	
	func commandReporterData() {
		writeStandardOutput("Data")
		writeStandardOutput("# OS")
		writeStandardOutput("## Memory")
		writeStandardOutput(data.osMemory.description)
		writeStandardOutput("## CPU")
		writeStandardOutput(data.osCPU.description)
		writeStandardOutput("## Processors")
		writeStandardOutput(data.osProcessors.description)
		writeStandardOutput("# Process")
		writeStandardOutput("## Memory")
		writeStandardOutput(data.processMemory.description)
		writeStandardOutput("## CPU")
		writeStandardOutput(data.processCPU.description)
		writeStandardOutput("## Thread")
		writeStandardOutput(data.processThread.description)
	}
}


// MARK: Command Test
extension CommandLine {
	
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
