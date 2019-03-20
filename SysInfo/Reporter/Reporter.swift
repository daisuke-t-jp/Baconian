//
//  Reporter.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

public class Reporter {

	// MARK: - Singleton
	public static let sharedManager = Reporter()
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
	
	/// A delegate of Reporter.
	weak private var delegate: ReporterDelegate?
	
	private var osMemoryInfo = Report.OS.Memory()
	private var processMemoryInfo = Report.Process.memory()
	private var threadInfo = Report.Process.thread()
}



// MARK: Operation
extension Reporter {
	
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
extension Reporter {
	
	private func startTimer(_ timeInterval: TimeInterval) {
		stop()
		
		timer = Timer.scheduledTimer(timeInterval: timeInterval,
									 target: self,
									 selector: #selector(onTimer),
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
extension Reporter {
	
	private func update() {
		let osMemoryInfo = Report.OS.memory()
		let processMemoryInfo = Report.Process.memory()
		let threadInfo = Report.Process.thread()
		
		var reporterData = Data()
		reporterData.osMemoryInfo = osMemoryInfo
		reporterData.processMemoryInfo = processMemoryInfo
		reporterData.threadInfo = threadInfo
		
		if osMemoryInfo.usedSize > self.osMemoryInfo.usedSize {
			reporterData.osMemoryGrowed = Int64(osMemoryInfo.usedSize - self.osMemoryInfo.usedSize)
		} else {
			reporterData.osMemoryGrowed = -Int64(self.osMemoryInfo.usedSize - osMemoryInfo.usedSize)
		}
		
		if processMemoryInfo.residentSize > self.processMemoryInfo.residentSize {
			reporterData.processMemoryGrowed = Int64(processMemoryInfo.residentSize -  self.processMemoryInfo.residentSize)
		} else {
			reporterData.processMemoryGrowed = -Int64(self.processMemoryInfo.residentSize -  processMemoryInfo.residentSize)
		}
		
		// reportData.processCPUUsageGrowed = threadInfo.cpuUsage - self.threadInfo.cpuUsage
		
		self.osMemoryInfo = osMemoryInfo
		self.processMemoryInfo = processMemoryInfo
		self.threadInfo = threadInfo
		
		
		guard let delegate = self.delegate else {
			return
		}
		
		delegate.reporter(self, didUpdate: reporterData)
	}
	
}



