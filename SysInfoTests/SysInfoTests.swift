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

	// MARK: - Mach host
    func testMachHostVMStatics() {
		let val = Mach.hostVMStatics()
		
		XCTAssertFalse(val.freeSize == 0 &&
			val.activeSize == 0 &&
			val.inactiveSize == 0 &&
			val.wireSize == 0)
    }

	func testMachHostCPULoadInfo() {
		let val = Mach.hostCPULoadInfo()
		
		XCTAssertFalse(val.userTick == 0 &&
		val.systemTick == 0 &&
		val.idleTick == 0 &&
		val.niceTick == 0)
	}
	
	func testMachHostProcessorInfo() {
		let array = Mach.hostProcessorInfo()
		XCTAssert(array.count > 0)
		
		for elm in array {
			XCTAssertFalse(elm.userTick == 0 &&
				elm.systemTick == 0 &&
				elm.idleTick == 0 &&
				elm.niceTick == 0)
		}
	}
	
	
	// MARK: - Mach task
	func testMachTaskBasicInfo() {
		let val = Mach.taskBasicInfo()
		
		XCTAssertFalse(val.virtualSize == 0 &&
			val.residentSize == 0 &&
			val.residentSizeMax == 0)
	}
	
	func testMachTaskThreadBasicInfo() {
		let array = Mach.taskThreadBasicInfo()
		XCTAssert(array.count > 0)
		
		for elm in array {
			XCTAssertFalse(elm.userTime == 0 &&
				elm.systemTime == 0)
		}
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
