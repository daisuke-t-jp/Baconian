//
//  MachHostProcessorInfo.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Mach {
	
	struct CPUTick {
		public var userTick = UInt32(0)
		public var systemTick = UInt32(0)
		public var idleTick = UInt32(0)
		public var niceTick = UInt32(0)
	}
	
}
