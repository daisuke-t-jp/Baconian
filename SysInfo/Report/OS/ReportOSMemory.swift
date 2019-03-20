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
		public var totalSize = UInt64(0)
		public var usedSize = UInt64(0)
		public var unusedSize = UInt64(0)
		
		public var freeSize = UInt64(0)
		public var activeSize = UInt64(0)
		public var inactiveSize = UInt64(0)
		public var wireSize = UInt64(0)
		
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
	
	static func memory() -> Memory {
		let machData = Mach.Host.vmStatics()
		
		var res = Memory()
		res.freeSize = machData.freeSize
		res.activeSize = machData.activeSize
		res.inactiveSize = machData.inactiveSize
		res.wireSize = machData.wireSize
		
		// TODO: Validation
		res.totalSize = UInt64(machData.freeSize) + UInt64(machData.activeSize) + UInt64(machData.inactiveSize) + UInt64(machData.wireSize)
		res.usedSize = UInt64(machData.activeSize) + UInt64(machData.wireSize)
		res.unusedSize = UInt64(res.totalSize) - UInt64(res.usedSize)
		
		return res
	}
	
}
