//
//  SysInfoReporterDelegate.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

/// The delegate of SysInfoReporter class.
public protocol SysInfoReporterDelegate: class {

	/// Delegate called when updated.
	///
	/// - Parameter manager: The SysInfoReporter reporting the event.
	/// - Parameter data: An data of report.
	func SysInfoReporter(_ manager: SysInfoReporter, didUpdate data: SysInfoReporter.SysInfoReportData)
}

/// The delegate for SysInfoReporterDelegate's optional func.
extension SysInfoReporterDelegate {
	/*
	func SysInfoReporter(_ manager: SysInfoReporter, didUpdate data: SysInfoReportData) {
		// Empty implementation to be "optional"
	}
	*/
}
