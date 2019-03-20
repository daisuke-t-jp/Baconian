//
//  ReporterDelegate.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

/// The delegate of Reporter class.
public protocol ReporterDelegate: class {
	
	/// Delegate called when updated.
	///
	/// - Parameter manager: The Reporter reporting the event.
	/// - Parameter data: An data of report.
	func reporter(_ manager: Reporter, didUpdate data: Reporter.Data)
}

/// The delegate for SysInfoReporterDelegate's optional func.
extension ReporterDelegate {
	/*
	func reporter(_ manager: Reporter, didUpdate data: Reporter.Data)
		// Empty implementation to be "optional"
	}
	*/
}
