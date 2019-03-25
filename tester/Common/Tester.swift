//
//  Tester.swift
//  SysInfoTester
//
//  Created by Daisuke T on 2019/03/25.
//  Copyright © 2019 SysInfoTester. All rights reserved.
//

import Foundation

class Tester: ReporterDelegate {
	
	// MARK: Property
	private let reporter = Reporter()
	public private(set) var data = Reporter.Data()
	private var memoryMap = [Date: [UInt8]]()
	private var threadMap = [Date: Thread]()
	
	init() {
		reporterDelegateEnable()
		reporterStart()
	}

}



// MARK: SysInfo Reporter Delegate
extension Tester {
	
	func reporter(_ manager: Reporter, didUpdate data: Reporter.Data) {
		self.data = data
	}
	
}


// TODO: freq
// MARK: Reporter
extension Tester {
	
	func reporterStart()  {
		 reporter.start()
	}
	
	func reporterStop() {
		reporter.stop()
	}
	
	func reporterDelegateEnable() {
		reporter.delegate = self
	}
	
	func reporterDelegateDisable() {
		reporter.delegate = nil
	}
	
}


// MARK: Memory
extension Tester {
	
	func memoryAlloc(_ byteSize: Int) {
		memoryMap[Date()] = [UInt8](repeating: 255, count: byteSize)
	}
	
	func memoryDealloc() {
		memoryMap = [Date: [UInt8]]()
	}
	
}


// MARK: Thread
extension Tester {
	
	@objc func threadFunc(_ array: [Any]) {
		autoreleasepool {
			
			print("start thread \(Thread.current)")
			
			guard let repeatCount = array[0] as? Int else {
				return
			}
			
			guard let sleepInterval = array[1] as? TimeInterval else {
				return
			}
			
			while(true) {
				autoreleasepool {
					let array = [UInt8](repeating: UInt8.max, count: repeatCount)
					var data = Data()
					for byte in array {
						data.append(byte)
					}
					
					if Thread.current.isCancelled {
						print("exit thread \(Thread.current)")
						Thread.exit()
					}
					
					Thread.sleep(forTimeInterval: sleepInterval)
				}
			}
			
		}
	}
	
	func threadCreate(_ repeatCount: Int, sleepInterval: TimeInterval) {
		let thread = Thread(target: self,
							selector: #selector(self.threadFunc),
							object: [repeatCount, sleepInterval])
		thread.start()
		threadMap[Date()] = thread
	}
	
	func threadDestroy() {
		for thread in threadMap.values {
			thread.cancel()
		}
		threadMap = [Date: Thread]()
	}

}
