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
	static let threadInterval = TimeInterval(0.1)
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
	private let operationQueue = OperationQueue()
	
	/// A delegate of Reporter.
	public var delegate: ReporterDelegate? {
		get {
			guard let operation = operationQueue.operations.first as? ReporterOperation else {
				return nil
			}
			
			return operation.delegate
		}
		
		set {
			guard let operation = operationQueue.operations.first as? ReporterOperation else {
				return
			}
			
			operation.delegate = newValue
		}
	}
	
	public var state: State {
		get {
			guard let operation = operationQueue.operations.first as? ReporterOperation else {
				return .stop
			}
			
			return operation.state
		}
		
		set {
			guard let operation = operationQueue.operations.first as? ReporterOperation else {
				return
			}
			
			operation.state = newValue
		}
	}
	
	public var frequency: Frequency {
		get {
			guard let operation = operationQueue.operations.first as? ReporterOperation else {
				return .normally
			}
			
			return operation.frequency
		}
		
		set {
			guard let operation = operationQueue.operations.first as? ReporterOperation else {
				return
			}
			
			operation.frequency = newValue
		}
	}
	
	
	// MARK: Initialize
	public init() {
		operationQueue.addOperation(ReporterOperation(reporter: self))
	}
	
	deinit {
		operationQueue.cancelAllOperations()
	}
	
}


// MARK: Control
extension Reporter {
	
	public func start() {
		stop()
		
		state = .run
	}
	
	public func stop() {
		state = .stop
	}
	
}

