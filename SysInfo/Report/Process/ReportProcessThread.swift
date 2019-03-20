//
//  ReportProcessThread.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension Report.Process {
	
	public struct Thread: CustomStringConvertible {
		let totalNum: Int
		let busyNum: Int
		let idleNum: Int
		
		public var description: String {
			return String(format: "totalNum[%@] busyNum[%@] idleNum[%@]",
						  totalNum,
						  busyNum,
						  idleNum
			)
		}
	}
}


extension Report.Process.Thread {
	
	init() {
		totalNum = 0
		busyNum = 0
		idleNum = 0
	}
	
}


extension Report.Process {
	
	static func thread() -> Thread {
		let array = Mach.Task.threadBasicInfo()
		
		var busy = Int(0)
		var idle = Int(0)
		
		for thread in array {
			guard !Mach.Task.threadBasicInfoIsIdle(thread) else {
				idle += 1
				continue
			}
			
			busy += 1
		}
		
		let res = Thread(totalNum: busy + idle, busyNum: busy, idleNum: idle)
		
		return res
	}
	
}
