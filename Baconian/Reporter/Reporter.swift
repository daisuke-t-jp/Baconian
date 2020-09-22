//
//  Reporter.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation

public class Reporter {
    
    // MARK: - Enum, Const
    static let threadInterval = TimeInterval(0.1)
    
    /// Frequency of report.
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
            guard let operation = operation else {
                return nil
            }
            
            return operation.delegate
        }
        
        set {
            guard let operation = operation else {
                return
            }
            
            operation.delegate = newValue
        }
    }
    
    public var state: State {
        get {
            guard let operation = operation else {
                return .stop
            }
            
            return operation.state
        }
        
        set {
            guard let operation = operation else {
                return
            }
            
            operation.state = newValue
        }
    }
    
    public var frequency: Frequency {
        get {
            guard let operation = operation else {
                return .normally
            }
            
            return operation.frequency
        }
        
        set {
            guard let operation = operation else {
                return
            }
            
            operation.frequency = newValue
        }
    }
    
    
    // MARK: Initialize
    public init() {
        initOperation()
    }
    
    deinit {
        deinitOperation()
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


// MARK: Operation
extension Reporter {
    
    func initOperation() {
        operationQueue.addOperation(ReporterOperation(reporter: self))
    }
    
    func deinitOperation() {
        operationQueue.cancelAllOperations()
    }
    
    var operation: ReporterOperation? {
        return operationQueue.operations.first as? ReporterOperation
    }
}
