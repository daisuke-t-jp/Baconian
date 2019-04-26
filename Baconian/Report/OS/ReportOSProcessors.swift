//
//  ReportOSProcessors.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation
import Mach_Swift

extension Report.OS {
  
  public static func processors(_ machHostProcessorInfo: [Mach.CPUTick],
                                machHostProcessorCPULoadInfoArray: [Mach.CPUTick]) -> [CPU] {
    
    var res = [CPU]()
    for i in 0..<machHostProcessorInfo.count {
      let machData = machHostProcessorInfo[i]
      var prevData = Mach.CPUTick()
      
      if i < machHostProcessorCPULoadInfoArray.count {
        prevData = machHostProcessorCPULoadInfoArray[i]
      }
      
      let cpu = CPU(machData, prevData: prevData)
      res.append(cpu)
    }
    
    return res
  }
  
}
