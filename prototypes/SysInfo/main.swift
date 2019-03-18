//
//  main.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

let enabledMach = false
let enabledDummyAllocation = false

var dummyMemory = [TimeInterval: [UInt]]()



class test: SysInfoReporterDelegate {
	
	func SysInfoReporter(_ manager: SysInfoReporter, didUpdate data: SysInfoReportData) {
		print("# Summary")
		print("- OSMemoryGrowed        : \(data.osMemoryGrowed.memoryByteFormatString)")
		print("- ProcessMemoryGrowed   : \(data.processMemoryGrowed.memoryByteFormatString)")
		print("- ProcessCPUUsageGrowed : \(data.processCPUUsageGrowed)[%]")
		print("# Detail")
		print("## OSMemory")
		print("- usedSize   : \(data.osMemoryInfo.usedSize.memoryByteFormatString)")
		print("- unusedSize : \(data.osMemoryInfo.unusedSize.memoryByteFormatString)")
		print("## ProcessMemory")
		print("- resident : \(data.processMemoryInfo.residentSize.memoryByteFormatString)")
		print("## Thread")
		print("- cpuUsage : \(data.threadInfo.cpuUsage)[%]")
		print("")
	}
	
}

var obj = test()
SysInfoReporter.sharedManager.start(obj)

while(true) {
	/*
	if enabledDummyAllocation {
		dummyMemory[Date().timeIntervalSinceNow] = [UInt](repeating: 32, count: 1024*1024*32)
	}
	
	if enabledMach {
		print("# Mach")
		
		let hostStatics = Mach.hostStatics()
		print("## HostStatics")
		print("- freeSize     : \(hostStatics.freeSize.decialFormatString)(B)")
		print("- activeSize   : \(hostStatics.activeSize.decialFormatString)(B)")
		print("- inactiveSize : \(hostStatics.inactiveSize.decialFormatString)(B)")
		print("- wireSize     : \(hostStatics.wireSize.decialFormatString)(B)")
		print("")
		
		let taskInfo = Mach.taskInfo()
		print("## TaskInfo")
		print("- virtualSize     : \(taskInfo.virtualSize.decialFormatString)(B)")
		print("- residentSize    : \(taskInfo.residentSize.decialFormatString)(B)")
		print("- residentSizeMax : \(taskInfo.residentSizeMax.decialFormatString)(B)")
		print("")
		
		let threadInfoArray = Mach.threadInfoArray()
		print("## ThreadInfo")
		for i in 0..<threadInfoArray.count {
			let threadInfo = threadInfoArray[i]
			print("### \(i)")
			print("- userTime     : \(threadInfo.userTime)[sec]")
			print("- systemTime   : \(threadInfo.systemTime)[sec]")
			print("- cpuUsage     : \(threadInfo.cpuUsage)[%]")
			print("- policy       : \(threadInfo.policy.description)")
			print("- runState     : \(threadInfo.runState.description)")
			print("- flags        : \(threadInfo.flags)")
			print("- suspendCount : \(threadInfo.suspendCount)")
			print("- sleepTime    : \(threadInfo.sleepTime)[sec]")
			print("")
		}
	}
	
	print("# SysInfo")
	
	let osMemoryInfo = SysInfo.osMemoryInfo()
	print("## OSMemoryInfo")
	print("- totalSize    : \(osMemoryInfo.totalSize.memoryByteFormatString)")
	print("- usedSize     : \(osMemoryInfo.usedSize.memoryByteFormatString)")
	print("- freeSize     : \(osMemoryInfo.freeSize.memoryByteFormatString)")
	print("- activeSize   : \(osMemoryInfo.activeSize.memoryByteFormatString)")
	print("- inactiveSize : \(osMemoryInfo.inactiveSize.memoryByteFormatString)")
	print("- wireSize     : \(osMemoryInfo.wireSize.memoryByteFormatString)")
	print("")
	
	let processMemoryInfo = SysInfo.processMemoryInfo()
	print("## ProcessMemoryInfo")
	print("- residentSize    : \(processMemoryInfo.residentSize.memoryByteFormatString)")
	print("- residentSizeMax : \(processMemoryInfo.residentSizeMax.memoryByteFormatString)")
	print("")
	
	let threadInfo = SysInfo.threadInfo()
	print("## ThreadInfo")
	print("- num        : \(threadInfo.num)")
	print("- idleNum    : \(threadInfo.idleNum)")
	print("- cpuUsage   : \(threadInfo.cpuUsage)[%]")
	print("- userTime   : \(threadInfo.userTime)[sec]")
	print("- systemTime : \(threadInfo.systemTime)[sec]")
	print("- time       : \(threadInfo.time)[sec]")
	print("")

	print("--------------------")
	print("")
	*/
	
	autoreleasepool {
		Thread.sleep(forTimeInterval: 0.001)
		RunLoop.current.run()
	}
}
