//
//  OSMemoryInfo.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension SysInfoReporter {
	
	public struct OSMemoryInfo {
		public var freeSize = UInt64(0)
		public var activeSize = UInt64(0)
		public var inactiveSize = UInt64(0)
		public var wireSize = UInt64(0)
		
		public var totalSize = UInt64(0)
		public var usedSize = UInt64(0)
		public var unusedSize = UInt64(0)
	}
	
	static func osMemoryInfo() -> OSMemoryInfo {
		let vmStatics = Mach.Host.VMStatics()
		
		var osMemoryInfo = OSMemoryInfo()
		osMemoryInfo.freeSize = vmStatics.freeSize
		osMemoryInfo.activeSize = vmStatics.activeSize
		osMemoryInfo.inactiveSize = vmStatics.inactiveSize
		osMemoryInfo.wireSize = vmStatics.wireSize
		
		osMemoryInfo.totalSize = UInt64(osMemoryInfo.freeSize) + UInt64(osMemoryInfo.activeSize) + UInt64(osMemoryInfo.inactiveSize) + UInt64(osMemoryInfo.wireSize)
		osMemoryInfo.usedSize = UInt64(osMemoryInfo.activeSize) + UInt64(osMemoryInfo.wireSize)
		osMemoryInfo.unusedSize = UInt64(osMemoryInfo.totalSize) - UInt64(osMemoryInfo.usedSize)
		
		return osMemoryInfo
	}
	
}
