//
//  ReportProcessMemory.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation
import Mach_Swift

extension Report.Process {
	
	public struct Memory: CustomStringConvertible {
		public let residentSize: UInt64
		
		public var description: String {
			return String(format: "residentSize: %@",
						  residentSize.memoryByteFormatString
			)
		}
	}
}


extension Report.Process.Memory {
	
	public init() {
		residentSize = 0
	}
	
}


extension Report.Process {
	
	public static func memory() -> Memory {
		let machData = Mach.Task.Info.basicInfo()
		
		let res = Memory(
			residentSize: machData.residentSize
		)
		
		return res
	}
	
}
