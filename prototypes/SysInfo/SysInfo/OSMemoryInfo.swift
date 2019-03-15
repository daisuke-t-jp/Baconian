//
//  OSMemoryInfo.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension SysInfo {
	
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
		let hostStatics = Mach.hostStatics()
		
		var osMemoryInfo = OSMemoryInfo()
		osMemoryInfo.freeSize = hostStatics.freeSize
		osMemoryInfo.activeSize = hostStatics.activeSize
		osMemoryInfo.inactiveSize = hostStatics.inactiveSize
		osMemoryInfo.wireSize = hostStatics.wireSize
		
		osMemoryInfo.totalSize = osMemoryInfo.freeSize + osMemoryInfo.activeSize + osMemoryInfo.inactiveSize + osMemoryInfo.wireSize
		osMemoryInfo.usedSize = osMemoryInfo.activeSize + osMemoryInfo.wireSize
		osMemoryInfo.unusedSize = osMemoryInfo.totalSize - osMemoryInfo.usedSize
		
		return osMemoryInfo
	}
	
}
