// 
//  ReporterOperation.swift
//  Baconian
//
//  Created by Daisuke T on 2019/04/05.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation

extension Reporter {
	
	class ReporterOperation: Operation {
		
		// MARK: Property
		private var lastProcessedDate = Date()
		private var machHostCPULoadInfoPrev = Mach.CPUTick()
		private var machHostProcessorInfoPrev = [Mach.CPUTick]()
		private weak var reporter: Reporter?
		
		// MARK: Initialize
		init(reporter: Reporter) {
			self.reporter = reporter
		}
		
		/// A delegate of Reporter.
		private let lockDelegate = NSLock()	// swiftlint:disable:this weak_delegate
		weak private var _delegate: ReporterDelegate?
		var delegate: ReporterDelegate? {
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
		var state: State {
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
		
		
		// MARK: Override
		override func main() {
			
			while !isCancelled {
				autoreleasepool {
					operationProc()
					
					Thread.sleep(forTimeInterval: Reporter.threadInterval)
				}
			}
			
		}
		
		
		// MARK: Operation
		private func operationProc() {
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
				
				guard let reporter = reporter else {
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
				
				delegate.reporter(reporter, didUpdate: data)
			}
			
		}
		
	}
	
}
