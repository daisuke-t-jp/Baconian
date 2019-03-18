//
//  ThreadInfo.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension SysInfoReporter {
	
	public struct ThreadInfo {
		public var num = Int(0)
		public var idleNum = Int(0)
		public var busyNum = Int(0)
		public var cpuUsage = Float(0)
		public var userTime = TimeInterval(0)
		public var systemTime = TimeInterval(0)
		public var time = TimeInterval(0)
	}
	
	static func threadInfo() -> ThreadInfo {
		let array = Mach.threadInfoArray()
		
		var threadInfo = ThreadInfo()
		threadInfo.num = array.count
		threadInfo.idleNum = Int(0)
		threadInfo.cpuUsage = Float(0)
		threadInfo.userTime = TimeInterval(0)
		threadInfo.systemTime = TimeInterval(0)
		threadInfo.time = TimeInterval(0)
		
		for thread in array {
			guard !Mach.threadInfoIsIdle(thread) else {
				threadInfo.idleNum = threadInfo.idleNum + 1
				continue
			}
			
			threadInfo.cpuUsage += (Float(thread.cpuUsage) / Float(TH_USAGE_SCALE)) * 100.0
			threadInfo.userTime += thread.userTime
			threadInfo.systemTime += thread.systemTime
		}
		
		threadInfo.busyNum = threadInfo.num - threadInfo.idleNum
		threadInfo.time = threadInfo.userTime + threadInfo.systemTime
		
		return threadInfo
	}
	
}
