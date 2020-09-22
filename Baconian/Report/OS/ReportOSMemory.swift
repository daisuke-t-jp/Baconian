//
//  ReportOSMemory.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation
import Mach_Swift

extension Report.OS {
    
    public struct Memory: CustomStringConvertible {
        public let physicalSize: UInt64	/// byte size
        
        public let freeSize: UInt64		/// byte size
        public let activeSize: UInt64	/// byte size
        public let inactiveSize: UInt64	/// byte size
        public let wireSize: UInt64		/// byte size
        
        /// byte size
        public var usedSize: UInt64 {
            return activeSize + inactiveSize + wireSize
        }
        
        /// byte size
        public var unusedSize: UInt64 {
            return physicalSize - usedSize
        }
        
        
        public var description: String {
            return String(format: "pysical: %@, used: %@, unused: %@ (free: %@, active: %@, inactive: %@, wire: %@)",
                          physicalSize.memoryByteFormatString,
                          usedSize.memoryByteFormatString,
                          unusedSize.memoryByteFormatString,
                          freeSize.memoryByteFormatString,
                          activeSize.memoryByteFormatString,
                          inactiveSize.memoryByteFormatString,
                          wireSize.memoryByteFormatString
            )
        }
    }
}


extension Report.OS.Memory {
    
    public init() {
        physicalSize = 0
        
        freeSize = 0
        activeSize = 0
        inactiveSize = 0
        wireSize = 0
    }
    
}


extension Report.OS {
    
    public static func memory() -> Memory {
        let vmInfo = Mach.Host.Statistics.vmInfo()
        let basicInfo = Mach.Host.Info.basicInfo()
        
        let res = Memory(
            physicalSize: basicInfo.maxMem,
            freeSize: vmInfo.freeSize,
            activeSize: vmInfo.activeSize,
            inactiveSize: vmInfo.inactiveSize,
            wireSize: vmInfo.wireSize
        )
        
        return res
    }
    
}
