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
		let osMemory: Report.OS.Memory
		let osCPU: Report.OS.CPU
		let osProcessors: [Report.OS.CPU]

		// Process
		let processMemory: Report.Process.Memory
		let processCPU: Report.Process.CPU
		let processThread: Report.Process.Thread
	}
	
}


extension Reporter.Data {
	
	init() {
		osMemory = Report.OS.Memory()
		osCPU = Report.OS.CPU()
		osProcessors = [Report.OS.CPU]()
		processMemory = Report.Process.Memory()
		processCPU = Report.Process.CPU()
		processThread = Report.Process.Thread()
	}
	
}
