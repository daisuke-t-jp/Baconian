//
//  SysInfoReportData.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

extension SysInfoReporter {
	public struct SysInfoReportData {
		// MARK: - Summary
		public var osMemoryGrowed = Int64(0)
		public var processMemoryGrowed = Int64(0)
		public var processCPUUsageGrowed = Float(0)
		
		// MARK: - Detail
		public var osMemoryInfo = Report.OS.Memory()
		public var processMemoryInfo = ProcessMemoryInfo()
		public var threadInfo = ThreadInfo()
	}
}
