//
//  SysInfoTests.swift
//  SysInfoTests
//
//  Created by Daisuke T on 2019/03/18.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import XCTest
@testable import SysInfo

class SysInfoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMachHostStatics() {
		let val = Mach.hostStatics()
		XCTAssertNotEqual(val.freeSize, 0)
		XCTAssertNotEqual(val.activeSize, 0)
		XCTAssertNotEqual(val.inactiveSize, 0)
		XCTAssertNotEqual(val.wireSize, 0)
    }

	func testMachTaskInfo() {
		let val = Mach.taskInfo()
		XCTAssertNotEqual(val.virtualSize, 0)
		XCTAssertNotEqual(val.residentSize, 0)
		XCTAssertNotEqual(val.residentSizeMax, 0)
	}
	
	func testMachThreadInfo() {
		let array = Mach.threadInfoArray()
		XCTAssert(array.count > 0)
	}
	
	func testOSMemoryInfo() {
		let val = SysInfoReporter.osMemoryInfo()
		XCTAssertNotEqual(val.freeSize, 0)
		XCTAssertNotEqual(val.activeSize, 0)
		XCTAssertNotEqual(val.inactiveSize, 0)
		XCTAssertNotEqual(val.wireSize, 0)
		XCTAssertNotEqual(val.totalSize, 0)
		XCTAssertNotEqual(val.usedSize, 0)
		XCTAssertNotEqual(val.unusedSize, 0)
	}
	
	func testProcessMemoryInfo() {
		let val = SysInfoReporter.processMemoryInfo()
		XCTAssertNotEqual(val.residentSize, 0)
		XCTAssertNotEqual(val.residentSizeMax, 0)
	}
	
	func testThreadInfo() {
		let val = SysInfoReporter.threadInfo()
		XCTAssertNotEqual(val.num, 0)
	}
	
	/*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
	*/

}
