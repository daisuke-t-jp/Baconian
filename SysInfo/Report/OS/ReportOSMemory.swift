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
		let physicalSize: UInt64
		let usedSize: UInt64
		let unusedSize: UInt64
		
		let freeSize: UInt64
		let activeSize: UInt64
		let inactiveSize: UInt64
		let wireSize: UInt64
		
		
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
		let machVMStatics = Mach.Host.vmStatics()
		let machBasicInfo = Mach.Host.basicInfo()
		
		let res = Memory(
			physicalSize: machBasicInfo.maxMem,
			usedSize: machVMStatics.activeSize + machVMStatics.inactiveSize + machVMStatics.wireSize,
			unusedSize: machBasicInfo.maxMem - UInt64(machVMStatics.activeSize + machVMStatics.inactiveSize + machVMStatics.wireSize),
			freeSize: machVMStatics.freeSize,
			activeSize: machVMStatics.activeSize,
			inactiveSize: machVMStatics.inactiveSize,
			wireSize: machVMStatics.wireSize
		)
		
		return res
	}
	
}
