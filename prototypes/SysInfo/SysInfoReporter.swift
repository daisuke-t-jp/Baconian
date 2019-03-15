//
//  SysInfoReporter.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

public class SysInfoReporter {
	
	// MARK: - Singleton
	private static let sharedManager = SysInfoReporter()
	private init() {
	}
	
	
	// MARK: - Enum, Const
	public static let defaultInterval = TimeInterval(10)
	
	
	// MARK: - Property
	private var timer: Timer?

	/// A delegate of BeaconDetectManager.
	weak private var delegate: SysInfoReporterDelegate?
	
	private var osMemoryInfo = SysInfo.OSMemoryInfo()
	private var processMemoryInfo = SysInfo.ProcessMemoryInfo()
	private var threadInfo = SysInfo.ThreadInfo()
}



// MARK: Operation
extension SysInfoReporter {
	
	public func start(_ delegate: SysInfoReporterDelegate, interval: TimeInterval = defaultInterval) {
		stop()
		
		self.delegate = delegate
		
		timer = Timer.scheduledTimer(timeInterval: interval,
									 target: self,
									 selector: #selector(SysInfoReporter.onTimer),
									 userInfo: nil,
									 repeats: true)
		
		guard let timer = timer else {
			return
		}
		
		RunLoop.current.add(timer, forMode: .common)
	}
	
	public func stop() {
		delegate = nil
		
		guard let timer = self.timer else {
			return
		}
		
		timer.invalidate()
		self.timer = nil
	}
	
}



// MARK: Timer
extension SysInfoReporter {
	
	@objc func onTimer() {
		update()
	}
	
}



// MARK: Update
extension SysInfoReporter {
	
	private func update() {
		let osMemoryInfo = SysInfo.osMemoryInfo()
		let processMemoryInfo = SysInfo.processMemoryInfo()
		let threadInfo = SysInfo.threadInfo()
		
		var reportData = SysInfoReportData()
		reportData.osMemoryInfo = osMemoryInfo
		reportData.processMemoryInfo = processMemoryInfo
		reportData.threadInfo = threadInfo
		
		if self.osMemoryInfo.usedSize > 0 && osMemoryInfo.usedSize > 0 {
			reportData.osMemoryGrowed = Int64(osMemoryInfo.usedSize - self.osMemoryInfo.usedSize)
		}
		if self.processMemoryInfo.residentSize > 0 && processMemoryInfo.residentSize > 0 {
			reportData.processMemoryGrowed = Int64(processMemoryInfo.residentSize - self.processMemoryInfo.residentSize)
		}
		if self.threadInfo.cpuUsage > 0.0 && threadInfo.cpuUsage > 0.0 {
			reportData.processCPUUsageGrowed = threadInfo.cpuUsage - self.threadInfo.cpuUsage
		}
		
		self.osMemoryInfo = osMemoryInfo
		self.processMemoryInfo = processMemoryInfo
		self.threadInfo = threadInfo
		
		guard let delegate = self.delegate else {
			return
		}
		
		delegate.SysInfoReporter(self, didUpdate: reportData)
	}
	
}


