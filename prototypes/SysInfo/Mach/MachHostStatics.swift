//
//  HostStatics.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Mach {
	
	struct HostStatics {
		public var freeSize = UInt32(0)
		public var activeSize = UInt32(0)
		public var inactiveSize = UInt32(0)
		public var wireSize = UInt32(0)
	}
	
	static func hostStatics() -> HostStatics {
		let hostPort = mach_host_self()
		var pageSize = vm_size_t()
		guard host_page_size(hostPort, &pageSize) == KERN_SUCCESS else {
			return HostStatics()
		}
		
		
		var machHostStatics = vm_statistics_data_t()
		var count = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.stride / MemoryLayout<integer_t>.stride)
		
		_ = withUnsafeMutablePointer(to: &machHostStatics) {
			$0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
				host_statistics(hostPort, Int32(HOST_VM_INFO), $0, &count)
			}
		}
		
		
		let pageSize2 = UInt32(pageSize)
		var hostStatics = HostStatics()
		hostStatics.freeSize = machHostStatics.free_count * pageSize2
		hostStatics.activeSize = machHostStatics.active_count * pageSize2
		hostStatics.inactiveSize = machHostStatics.inactive_count * pageSize2
		hostStatics.wireSize = machHostStatics.wire_count * pageSize2
		
		return hostStatics
	}
}

