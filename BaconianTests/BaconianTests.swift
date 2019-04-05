//
//  BaconianTests.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/18.
//  Copyright © 2019 Baconian. All rights reserved.
//

import XCTest

#if !BACONIAN_TESTER
@testable import Baconian
#endif

class BaconianTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	// MARK: - Mach.Host
    func testMachHostVMStatics() {
		let val = Mach.Host.vmStatics()
		
		XCTAssertFalse(val.freeSize == 0 &&
			val.activeSize == 0 &&
			val.inactiveSize == 0 &&
			val.wireSize == 0)
    }
	
	func testMachHostBasicInfo() {
		let val = Mach.Host.basicInfo()
		
		XCTAssertFalse(val.maxCPUs == 0 &&
			val.availCPUs == 0 &&
			val.memorySize == 0 &&
			val.cpuType == 0 &&
			val.cpuSubType == 0 &&
			val.cpuThreadType == 0 &&
			val.physicalCPU == 0 &&
			val.physicalCPUMax == 0 &&
			val.logicalCPU == 0 &&
			val.logicalCPUMax == 0 &&
			val.maxMem == 0)
	}
	
	func testMachHostCPULoadInfo() {
		let val = Mach.Host.cpuLoadInfo()
		
		XCTAssertFalse(val.userTick == 0 &&
			val.systemTick == 0 &&
			val.idleTick == 0 &&
			val.niceTick == 0)
	}
	
	func testMachHostProcessorInfo() {
		let array = Mach.Host.processorInfo()
		
		XCTAssertNotEqual(array.count, 0)
		
		for elm in array {
			XCTAssertFalse(elm.userTick == 0 &&
				elm.systemTick == 0 &&
				elm.idleTick == 0 &&
				elm.niceTick == 0)
		}
	}
	
	
	// MARK: - Mach.Task
	func testMachTaskBasicInfo() {
		let val = Mach.Task.basicInfo()
		
		XCTAssertFalse(val.virtualSize == 0 &&
			val.residentSize == 0 &&
			val.residentSizeMax == 0)
	}
	
	func testMachTaskThreadBasicInfo() {
		let array = Mach.Task.threadBasicInfo()
		
		XCTAssertNotEqual(array.count, 0)
	}
	
	
	// MARK: - Report.OS
	func testReportOSMemory() {
		let val = Report.OS.memory()
		
		XCTAssertFalse(val.physicalSize == 0 &&
			val.usedSize == 0 &&
			val.unusedSize == 0 &&
			val.freeSize == 0 &&
			val.activeSize == 0 &&
			val.inactiveSize == 0 &&
			val.wireSize == 0)
	}
	
	func testReportOSCPU() {
		let val = Report.OS.cpu(Mach.Host.cpuLoadInfo(),
								machHostCPULoadInfoPrev: Mach.Host.cpuLoadInfo())
		
		XCTAssertFalse(val.userUsage == 0 &&
			val.systemUsage == 0 &&
			val.idleUsage == 0 &&
			val.niceUsage == 0 &&
			val.usage == 0)
	}
	
	func testReportOSProcessors() {
		let array = Report.OS.processors(Mach.Host.processorInfo(),
										 machHostProcessorInfoPrev: Mach.Host.processorInfo())
		
		XCTAssertNotEqual(array.count, 0)
	}
	
	
	// MARK: - Report.Process
	func testReportProcessMemory() {
		let val = Report.Process.memory()
		
		XCTAssertNotEqual(val.residentSize, 0)
	}
	
	func testReportProcessCPU() {
		// NOP
	}
	
	func testReportProcessThread() {
		let val = Report.Process.thread()
		
		XCTAssert(val.totalNum > 0)
		XCTAssertEqual(val.totalNum, val.busyNum + val.idleNum)
	}
	
}