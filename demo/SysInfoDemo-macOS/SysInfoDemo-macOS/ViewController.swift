//
//  ViewController.swift
//  SysInfoDemo-macOS
//
//  Created by Daisuke T on 2019/03/18.
//  Copyright © 2019 SysInfoDemo-macOS. All rights reserved.
//

import Cocoa
import SysInfo

class ViewController: NSViewController, SysInfoReporterDelegate {
	
	@IBOutlet weak var textFieldSummaryOSMemoryGrowed: NSTextField!

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		SysInfoReporter.sharedManager.start(self)
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	func sysInfoReporter(_ manager: SysInfoReporter, didUpdate data: SysInfoReporter.SysInfoReportData) {
		
		textFieldSummaryOSMemoryGrowed.stringValue = "- OSMemoryGrowed : \(data.osMemoryGrowed.memoryByteFormatString)"
		
	}
	
}

