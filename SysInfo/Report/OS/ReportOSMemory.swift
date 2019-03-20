//
//  ReportOSMemory.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Report.OS {
	
	public struct Memory: CustomStringConvertible {
		let totalSize: UInt64
		let usedSize: UInt64
		let unusedSize: UInt64
		
		let freeSize: UInt64
		let activeSize: UInt64
		let inactiveSize: UInt64
		let wireSize: UInt64
		
		
		public var description: String {
			return String(format: "total[%@] used[%@] unused[%@](free[%@] active[%@] inactive[%@] wire[%@])",
						  totalSize.memoryByteFormatString,
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
		totalSize = 0
		usedSize = 0
		unusedSize = 0
		
		freeSize = 0
		activeSize = 0
		inactiveSize = 0
		wireSize = 0
	}
	
}


extension Report.OS {
	
	static func memory() -> Memory {
		let machData = Mach.Host.vmStatics()
		
		// TODO: Validation
		let res = Memory(
			totalSize: UInt64(machData.freeSize) + UInt64(machData.activeSize) + UInt64(machData.inactiveSize) + UInt64(machData.wireSize),
			usedSize: UInt64(machData.activeSize) + UInt64(machData.wireSize),
			unusedSize: UInt64(machData.freeSize) - UInt64(machData.inactiveSize),
			freeSize: machData.freeSize,
			activeSize: machData.activeSize,
			inactiveSize: machData.inactiveSize,
			wireSize: machData.wireSize
		)
		
		return res
	}
	
}
