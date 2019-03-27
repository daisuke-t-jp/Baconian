//
//  ReporterView.swift
//  SysInfo-macOS
//
//  Created by Daisuke T on 2019/03/27.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation
import Cocoa

// TODO: set delegate
// TODO: create view
// TODO: set reporter parameter(e.g. frequency)
class ReporterView: NSView, ReporterDelegate {
	
	// MARK: Outlet
	@IBOutlet weak var textFieldOSHeader: NSTextField!
	@IBOutlet weak var textFieldOSMemoryMax: NSTextField!
	@IBOutlet weak var textFieldOSMemory: NSTextField!
	@IBOutlet weak var textFieldOSCPU: NSTextField!
	@IBOutlet weak var textFieldProcessHeader: NSTextField!
	@IBOutlet weak var textFieldProcessMemory: NSTextField!
	@IBOutlet weak var textFieldProcessCPU: NSTextField!
	
	
	// MARK: Property
	let reporter = Reporter()
	var textColor = NSColor.white {
		didSet {
			setTextFieldColor(textColor)
		}
	}
	
	var backgroundColor = NSColor.black {
		didSet {
			setBackgroundColor(backgroundColor)
		}
	}
	
	
	// MARK: Initialize
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		
		initInternal()
	}
	
	required init?(coder decoder: NSCoder) {
		super.init(coder: decoder)
		
		initInternal()
	}
	
	func initInternal() {
		reporter.delegate = self
		wantsLayer = true
		
		setBackgroundColor(backgroundColor)
		initTextField()
		
	}
}


// MARK: SysInfo Reporter Delegate
extension ReporterView {
	
	func reporter(_ manager: Reporter, didUpdate data: Reporter.Data) {
		updateTextField(data)
	}
	
}


// MARK: Operation
extension ReporterView {
	
	func start() {
		reporter.start()
	}
	
	func stop() {
		reporter.stop()
	}
	
}


// MARK: View
extension ReporterView {
	
	public func setBackgroundColor(_ color: NSColor) {
		layer?.backgroundColor = color.cgColor
	}
	
}


// MARK: TextField
extension ReporterView {
	
	func initTextField() {
		setTextFieldColor(textColor)
		
		textFieldOSHeader.stringValue = "# OS"
		textFieldOSMemoryMax.stringValue = "- Max Memory: "
		textFieldOSMemory.stringValue = "- Memory: "
		textFieldOSCPU.stringValue = "- CPU: "
		
		textFieldProcessHeader.stringValue = "# Process"
		textFieldProcessMemory.stringValue = "- Memory: "
		textFieldProcessCPU.stringValue = "- CPU: "
	}
	
	func setTextFieldColor(_ color: NSColor) {
		for elm in textFieldArray() {
			elm.textColor = color
		}
	}
	
	func textFieldArray() -> [NSTextField] {
		return [
			textFieldOSHeader,
			textFieldOSMemoryMax,
			textFieldOSMemory,
			textFieldOSCPU,
			textFieldProcessHeader,
			textFieldProcessMemory,
			textFieldProcessCPU,
		]
	}
	
	func updateTextField(_ data: Reporter.Data) {
		textFieldOSMemoryMax.stringValue = "Memory Max: \(data.osMemory.physicalSize.memoryByteFormatString)"
		textFieldOSMemory.stringValue = "Memory: \(data.osMemory.usedSize.memoryByteFormatString)"
		textFieldOSCPU.stringValue = String(format: "CPU: %.2f%%", 1.0 - data.osCPU.idleUsage)
		
		textFieldProcessMemory.stringValue = "Memory: \(data.processMemory.residentSize.memoryByteFormatString)"
		textFieldProcessCPU.stringValue = String(format: "CPU: %.2f%%", 1.0 - data.processCPU.usage)
	}
	
}
