//
//  Reporter.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

public class Reporter {
	
	// MARK: - Enum, Const
	private static let threadInterval = TimeInterval(0.1)
	public enum Frequency: TimeInterval {
		case normally = 5
		case often = 2
		case veryOften = 1
	}
	
	public enum State {
		case stop
		case run
	}
	
	
	// MARK: - Property
	private var thread: Thread?
	
	/// A delegate of Reporter.
	private let lockDelegate = NSLock()	// swiftlint:disable:this weak_delegate
	weak private var _delegate: ReporterDelegate?
	public var delegate: ReporterDelegate? {
		get {
			lockDelegate.lock()
			let val = _delegate
			lockDelegate.unlock()
			return val
		}
		
		set {
			lockDelegate.lock()
			_delegate = newValue
			lockDelegate.unlock()
		}
	}
	
	private let lockState = NSLock()
	private var _state: State = .stop
	public var state: State {
		get {
			lockState.lock()
			let val = _state
			lockState.unlock()
			return val
		}
		
		set {
			lockState.lock()
			_state = newValue
			lockState.unlock()
		}
	}
	
	private let lockFrequency = NSLock()
	private var _frequency: Frequency = .normally
	public var frequency: Frequency {
		get {
			lockFrequency.lock()
			let val = _frequency
			lockFrequency.unlock()
			return val
		}
		
		set {
			lockFrequency.lock()
			_frequency = newValue
			lockFrequency.unlock()
		}
	}
	
	private var lastProcessedDate = Date()
}



// MARK: Operation
extension Reporter {
	
	public func start() {
		stop()
		
		state = .run
		
		startThread()
	}
	
	public func stop() {
		state = .stop
		
		stopThread()
	}
	
}



// MARK: Thread
extension Reporter {
	
	private func startThread() {
		guard thread == nil else {
			// Thread was created.
			return
		}
		
		thread = Thread(target: self,
						selector: #selector(threadLoop),
						object: nil)
		
		guard let thread = thread else {
			return
		}
		
		thread.start()
	}
	
	private func stopThread() {
		// NOP
	}
	
	@objc private func threadLoop() {
		autoreleasepool {
			while true {
				autoreleasepool {
					threadFunc()
					
					Thread.sleep(forTimeInterval: Reporter.threadInterval)
				}
			}
		}
	}
	
	private func threadFunc() {
		guard state == .run else {
			return
		}
		
		
		// Check time interval.
		let date = Date()
		let interval = date.timeIntervalSince(lastProcessedDate)
		guard interval > frequency.rawValue else {
			return
		}
		
		
		// Get report's data and tell the delegate.
		do {
			lockDelegate.lock()
			defer {
				lastProcessedDate = date
				lockDelegate.unlock()
			}
			
			guard let delegate = _delegate else {
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
	
}
