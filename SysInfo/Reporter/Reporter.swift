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
	weak public var delegate: ReporterDelegate?
	
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
		guard let delegate = self.delegate else {
			return
		}
		
		let data = Reporter.Data(osMemory: Report.OS.memory(),
								 osCPU: Report.OS.cpu(),
								 osProcessors: Report.OS.processors(),
								 processMemory: Report.Process.memory(),
								 processCPU: Report.Process.cpu(),
								 processThread: Report.Process.thread())
		
		delegate.reporter(self, didUpdate: data)
	}
	
}



