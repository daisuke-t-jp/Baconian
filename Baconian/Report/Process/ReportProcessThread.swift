//
//  ReportProcessThread.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation
import Mach_Swift

extension Report.Process {
  
  public struct Thread: CustomStringConvertible {
    public let totalNum: Int
    public let busyNum: Int
    public let idleNum: Int
    
    public var description: String {
      return String(format: "totalNum: %d, busyNum: %d, idleNum: %d",
                    totalNum,
                    busyNum,
                    idleNum
      )
    }
  }
}


extension Report.Process.Thread {
  
  public init() {
    totalNum = 0
    busyNum = 0
    idleNum = 0
  }
  
}


extension Report.Process {
  
  public static func thread() -> Thread {
    let array = Mach.Task.Thread.basicInfoArray()
    
    var busy = Int(0)
    var idle = Int(0)
    
    for thread in array {
      guard !Mach.Task.Thread.basicInfoIsIdle(thread) else {
        idle += 1
        continue
      }
      
      busy += 1
    }
    
    let res = Thread(totalNum: busy + idle, busyNum: busy, idleNum: idle)
    
    return res
  }
  
}
