//
//  ReportOSMemory.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation

extension Report.OS {
	
	public struct Memory: CustomStringConvertible {
		let physicalSize: UInt64
		
		let freeSize: UInt64
		let activeSize: UInt64
		let inactiveSize: UInt64
		let wireSize: UInt64
		
		var usedSize: UInt64 {
			return activeSize + inactiveSize + wireSize
		}
		
		var unusedSize: UInt64 {
			return physicalSize - usedSize
		}
		
		
		public var description: String {
			return String(format: "pysical: %@, used: %@, unused: %@ (free: %@, active: %@, inactive: %@, wire: %@)",
						  physicalSize.memoryByteFormatString,
						  usedSize.memoryByteFormatString,
						  unusedSize.memoryByteFormatString,
						  freeSize.memoryByteFormatString,
						  activeSize.memoryByteFormatString,
						  inactiveSize.memoryByteFormatString,
						  wireSize.memoryByteFormatString
			)
		}
	}
}


extension Report.OS.Memory {
	
	init() {
		physicalSize = 0
		
		freeSize = 0
		activeSize = 0
		inactiveSize = 0
		wireSize = 0
	}
	
}


extension Report.OS {
	
	static func memory() -> Memory {
		let machVMStatics = Mach.Host.vmStatics()
		let machBasicInfo = Mach.Host.basicInfo()
		
		let res = Memory(
			physicalSize: machBasicInfo.maxMem,
			freeSize: machVMStatics.freeSize,
			activeSize: machVMStatics.activeSize,
			inactiveSize: machVMStatics.inactiveSize,
			wireSize: machVMStatics.wireSize
		)
		
		return res
	}
	
}
