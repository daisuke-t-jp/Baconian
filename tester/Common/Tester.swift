//
//  Tester.swift
//  SysInfoTester
//
//  Created by Daisuke T on 2019/03/25.
//  Copyright © 2019 SysInfoTester. All rights reserved.
//

import Foundation

class Tester {
	
	// MARK: Property
	private var memoryMap = [Date: [UInt8]]()
	private var threadMap = [Date: Thread]()

	init() {
	}
	
}


// MARK: Memory
extension Tester {
	
	public func memoryAlloc(_ byteSize: Int) {
		memoryMap[Date()] = [UInt8](repeating: UInt8.max, count: byteSize)
	}
	
	public func memoryDealloc() {
		memoryMap = [Date: [UInt8]]()
	}
	
}


// MARK: Thread
extension Tester {
	
	public func threadCreate(_ repeatCount: Int, sleepInterval: TimeInterval) {
		let thread = Thread(target: self,
							selector: #selector(self.threadEntry),
							object: [repeatCount, sleepInterval])
		thread.start()
		threadMap[Date()] = thread
	}
	
	public func threadDestroy() {
		for thread in threadMap.values {
			thread.cancel()
		}
		threadMap = [Date: Thread]()
	}
	
	@objc private func threadEntry(_ array: [Any]) {
		autoreleasepool {
			
			print("start thread \(Thread.current)")
			
			guard let repeatCount = array[0] as? Int else {
				return
			}
			
			guard let sleepInterval = array[1] as? TimeInterval else {
				return
			}
			
			while true {
				autoreleasepool {
					threadProc(repeatCount)
					
					if Thread.current.isCancelled {
						print("exit thread \(Thread.current)")
						Thread.exit()
					}
					
					Thread.sleep(forTimeInterval: sleepInterval)
				}
			}
			
		}
	}
	
	private func threadProc(_ repeatCount: Int) {
		let array = [UInt8](repeating: UInt8.max, count: repeatCount)
		var data = Data()
		for byte in array {
			data.append(byte)
		}
	}

}
