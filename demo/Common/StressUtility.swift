//
//  StressUtility.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/25.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation

/// StressUtility
class StressUtility {
    
    // MARK: Property
    private var memoryArray = [[UInt8]]()
    private let operationQueue = OperationQueue()
    
    
    // MARK: Initialize
    init() {
    }
    
    deinit {
        memoryDealloc()
        operationCancel()
    }
}


// MARK: Memory
extension StressUtility {
    
    public func memoryAlloc(_ byteSize: Int) {
        memoryArray.append([UInt8](repeating: UInt8.max, count: byteSize))
    }
    
    public func memoryDealloc() {
        memoryArray.removeAll()
    }
    
    public func memorySize() -> UInt64 {
        var total = UInt64(0)
        
        for mem in memoryArray {
            total += UInt64(mem.count)
        }
        
        return total
    }
    
}


// MARK: Operation
extension StressUtility {
    
    class StressOperation: Operation {
        
        // MARK: Property
        let repeatCount: Int
        let sleepInterval: TimeInterval
        
        
        // MARK: Initialize
        init(_ repeatCount: Int, sleepInterval: TimeInterval) {
            self.repeatCount = repeatCount
            self.sleepInterval = sleepInterval
        }
        
        
        // MARK: Override
        override func main() {
            print("start operation thread[\(Thread.current)]")
            
            while !isCancelled {
                autoreleasepool {
                    for _ in 0..<repeatCount {
                        _ = Data(capacity: 1000)
                        
                        if isCancelled {
                            break
                        }
                    }
                    
                    Thread.sleep(forTimeInterval: sleepInterval)
                }
            }
            
            print("exit operation thread[\(Thread.current)]")
        }
    }
    
    private func operationInit() {
        operationQueue.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
    }
    
    public func operationAdd(_ repeatCount: Int, sleepInterval: TimeInterval) {
        operationQueue.addOperation(StressOperation(repeatCount, sleepInterval: sleepInterval))
    }
    
    public func operationCancel() {
        operationQueue.cancelAllOperations()
        operationQueue.waitUntilAllOperationsAreFinished()
    }
    
    public func operationCount() -> Int {
        return operationQueue.operationCount
    }
    
}
