//
//  ReporterData.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation

extension Reporter {
    
    public struct Data {
        // OS
        public let osMemory: Report.OS.Memory
        public let osCPU: Report.OS.CPU
        public let osProcessors: [Report.OS.CPU]
        
        // Process
        public let processMemory: Report.Process.Memory
        public let processCPU: Report.Process.CPU
        public let processThread: Report.Process.Thread
    }
    
}


extension Reporter.Data {
    
    public init() {
        osMemory = Report.OS.Memory()
        osCPU = Report.OS.CPU()
        osProcessors = [Report.OS.CPU]()
        processMemory = Report.Process.Memory()
        processCPU = Report.Process.CPU()
        processThread = Report.Process.Thread()
    }
    
}
