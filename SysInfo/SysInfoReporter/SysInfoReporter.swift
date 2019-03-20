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
	public static let sharedManager = SysInfoReporter()
	private init() {
	}
	
	
	// MARK: - Enum, Const
	public enum UpdateFrequency: TimeInterval {
		case normally = 5
		case often = 2
		case veryOften = 1
	}
	
	public enum State {
		case stop
		case run
	}
	
	
	// MARK: - Property
	public private(set) var state = State.stop
	private var timer: Timer?
	public var updateFrequency: UpdateFrequency = .normally {
		didSet {
			if state == .run {
				start()
			}
		}
	}

	/// A delegate of SysInfoReporter.
	weak private var delegate: SysInfoReporterDelegate?
	
	private var osMemoryInfo = OSMemoryInfo()
	private var processMemoryInfo = ProcessMemoryInfo()
	private var threadInfo = ThreadInfo()
}



// MARK: Operation
extension SysInfoReporter {
	
	public func start() {
		stop()
		
		state = .run
		
		startTimer(updateFrequency.rawValue)
	}
	
	public func stop() {
		state = .stop
		
		stopTimer()
	}
	
}



// MARK: Timer
extension SysInfoReporter {
	
	private func startTimer(_ timeInterval: TimeInterval) {
		stop()
		
		timer = Timer.scheduledTimer(timeInterval: timeInterval,
									 target: self,
									 selector: #selector(SysInfoReporter.onTimer),
									 userInfo: nil,
									 repeats: true)
		
		// TODO: Must be care that case of run on sub thread.
	}
	
	private func stopTimer() {
		guard let timer = self.timer else {
			return
		}
		
		timer.invalidate()
		self.timer = nil
	}
	
	@objc private func onTimer() {
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


