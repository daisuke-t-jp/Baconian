//
//  ReportProcessCPU.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation
import Mach_Swift

extension Report.Process {
  
  public struct CPU: CustomStringConvertible {
    public let usage: Float	/// 0...1
    public let time: TimeInterval
    
    public var description: String {
      return String(format: "usage: %.2f%%, time: %.2fs",
                    usage * 100,
                    time
      )
    }
  }
}


extension Report.Process.CPU {
  
  public init() {
    usage = 0
    time = 0
  }
  
}


extension Report.Process {
  
  public static func cpu() -> CPU {
    let array = Mach.Task.Thread.basicInfoArray()
    let machBasicInfo = Mach.Host.Info.basicInfo()
    
    var usage = Float(0)
    var time = TimeInterval(0)
    
    for thread in array {
      guard !Mach.Task.Thread.basicInfoIsIdle(thread) else {
        continue
      }
      
      usage += Float(thread.cpuUsage) / Float(TH_USAGE_SCALE)
      time += thread.userTime
      time += thread.systemTime
    }
    
    usage /= Float(machBasicInfo.maxCPUs == 0 ? 1 : machBasicInfo.maxCPUs)
    let res = CPU(usage: usage, time: time)
    
    return res
  }
  
}
