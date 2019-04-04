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
		case normally = 5	/// 5 sec
		case often = 2		/// 2 sec
		case veryOften = 1	/// 1 sec
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
	private var machHostCPULoadInfoPrev = Mach.CPUTick()
	private var machHostProcessorInfoPrev = [Mach.CPUTick]()
	
	
	// MARK: Initialize
	public init() {
	}
	
}



// MARK: Control
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
						selector: #selector(threadEntry),
						object: nil)
		
		guard let thread = thread else {
			return
		}
		
		thread.start()
	}
	
	private func stopThread() {
		// NOP
	}
	
	@objc private func threadEntry() {
		autoreleasepool {
			while true {
				autoreleasepool {
					threadProc()
					
					Thread.sleep(forTimeInterval: Reporter.threadInterval)
				}
			}
		}
	}
	
	private func threadProc() {
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
			
			let machHostCPULoadInfo = Mach.Host.cpuLoadInfo()
			let machHostProcessorInfo = Mach.Host.processorInfo()
			let data = Reporter.Data(osMemory: Report.OS.memory(),
									 osCPU: Report.OS.cpu(machHostCPULoadInfo,
														  machHostCPULoadInfoPrev: machHostCPULoadInfoPrev),
									 osProcessors: Report.OS.processors(machHostProcessorInfo,
																		machHostProcessorInfoPrev: machHostProcessorInfoPrev),
									 processMemory: Report.Process.memory(),
									 processCPU: Report.Process.cpu(),
									 processThread: Report.Process.thread())
			
			
			// Caching prev data
			machHostCPULoadInfoPrev = machHostCPULoadInfo
			machHostProcessorInfoPrev = machHostProcessorInfo
			
			delegate.reporter(self, didUpdate: data)
		}

	}
	
}
