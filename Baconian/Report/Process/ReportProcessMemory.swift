//
//  ReportProcessMemory.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation

extension Report.Process {
	
	public struct Memory: CustomStringConvertible {
		let residentSize: UInt64
		
		public var description: String {
			return String(format: "residentSize: %@",
						  residentSize.memoryByteFormatString
			)
		}
	}
}


extension Report.Process.Memory {
	
	init() {
		residentSize = 0
	}
	
}


extension Report.Process {
	
	static func memory() -> Memory {
		let machData = Mach.Task.basicInfo()
		
		let res = Memory(
			residentSize: machData.residentSize
		)
		
		return res
	}
	
}
