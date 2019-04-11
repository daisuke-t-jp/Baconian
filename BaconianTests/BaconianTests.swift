//
//  BaconianTests.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/18.
//  Copyright © 2019 Baconian. All rights reserved.
//

import XCTest
import Mach_Swift

@testable import Baconian

class BaconianTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
		let val = Report.OS.cpu(Mach.Host.Statistics.cpuLoadInfo(),
								machHostStatisticsCPULoadInfoPrev: Mach.Host.Statistics.cpuLoadInfo())
		
		XCTAssertFalse(val.userUsage == 0 &&
			val.systemUsage == 0 &&
			val.idleUsage == 0 &&
			val.niceUsage == 0 &&
			val.usage == 0)
	}
	
	func testReportOSProcessors() {
		let array = Report.OS.processors(Mach.Host.Processor.cpuLoadInfoArray(),
										 machHostProcessorCPULoadInfoArray: Mach.Host.Processor.cpuLoadInfoArray())
		
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
