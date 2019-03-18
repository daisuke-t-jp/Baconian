//
//  SysInfoReporter.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

// TODO: readme
// TODO: podspec
// TODO: mac demo
// TODO: ui(view)
// TODO: jazzy
// TODO: header image
// TODO: iOS


public class SysInfoReporter {
	
	// MARK: - Singleton
	public static let sharedManager = SysInfoReporter()
	private init() {
	}
	
	
	// MARK: - Enum, Const
	public static let defaultInterval = TimeInterval(1)
	public enum State {
		case stop
		case run
		case pause
	}
	
	// MARK: - Property
	public private(set) var state = State.stop
	private var timer: Timer?

	/// A delegate of SysInfoReporter.
	weak private var delegate: SysInfoReporterDelegate?
	
	private var osMemoryInfo = OSMemoryInfo()
	private var processMemoryInfo = ProcessMemoryInfo()
	private var threadInfo = ThreadInfo()
}



// MARK: Operation
extension SysInfoReporter {
	
	public func start(_ delegate: SysInfoReporterDelegate, interval: TimeInterval = defaultInterval) {
		stop()
		
		state = .run
		self.delegate = delegate
		
		timer = Timer.scheduledTimer(timeInterval: interval,
									 target: self,
									 selector: #selector(SysInfoReporter.onTimer),
									 userInfo: nil,
									 repeats: true)
		
		/*
		guard timer != nil else {
			return
		}
		
		RunLoop.current.add(timer, forMode: .common)
		*/
	}
	
	public func pause() {
		state = .pause
	}
	
	public func stop() {
		state = .stop
		
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
	
	@objc private func onTimer() {
		guard !(state == .pause) else {
			return
		}
		
		update()
	}
	
}



// MARK: Update
extension SysInfoReporter {
	
	private func update() {
		let osMemoryInfo = SysInfoReporter.osMemoryInfo()
		let processMemoryInfo = SysInfoReporter.processMemoryInfo()
		let threadInfo = SysInfoReporter.threadInfo()
		
		var reportData = SysInfoReportData()
		reportData.osMemoryInfo = osMemoryInfo
		reportData.processMemoryInfo = processMemoryInfo
		reportData.threadInfo = threadInfo
		
		if osMemoryInfo.usedSize > self.osMemoryInfo.usedSize {
			reportData.osMemoryGrowed = Int64(osMemoryInfo.usedSize - self.osMemoryInfo.usedSize)
		} else {
			reportData.osMemoryGrowed = -Int64(self.osMemoryInfo.usedSize - osMemoryInfo.usedSize)
		}
		
		if processMemoryInfo.residentSize > self.processMemoryInfo.residentSize {
			reportData.processMemoryGrowed = Int64(processMemoryInfo.residentSize -  self.processMemoryInfo.residentSize)
		} else {
			reportData.processMemoryGrowed = -Int64(self.processMemoryInfo.residentSize -  processMemoryInfo.residentSize)
		}

		reportData.processCPUUsageGrowed = threadInfo.cpuUsage - self.threadInfo.cpuUsage
		
		self.osMemoryInfo = osMemoryInfo
		self.processMemoryInfo = processMemoryInfo
		self.threadInfo = threadInfo
		
		guard let delegate = self.delegate else {
			return
		}
		
		delegate.sysInfoReporter(self, didUpdate: reportData)
	}
	
}


