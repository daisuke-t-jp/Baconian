//
//  ReporterView.swift
//  SysInfo-macOS
//
//  Created by Daisuke T on 2019/03/27.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation
import Cocoa

// TODO: create view
typealias ReporterViewDelegate = ReporterDelegate

class ReporterView: NSView, ReporterDelegate {
	
	// MARK: Outlet
	@IBOutlet var textFieldOSHeader: NSTextField!
	@IBOutlet var textFieldOSMemoryMax: NSTextField!
	@IBOutlet var textFieldOSMemory: NSTextField!
	@IBOutlet var textFieldOSCPU: NSTextField!
	@IBOutlet var textFieldProcessHeader: NSTextField!
	@IBOutlet var textFieldProcessMemory: NSTextField!
	@IBOutlet var textFieldProcessCPU: NSTextField!
	
	
	// MARK: Property
	private let reporter = Reporter()
	weak public var delegate: ReporterViewDelegate?
	
	public var state: Reporter.State {
		return reporter.state
	}
	
	public var textColor = NSColor.white {
		didSet {
			for textField in textFieldArray() {
				textField.textColor = textColor
			}
		}
	}
	
	public var backgroundColor = NSColor.black {
		didSet {
			layer?.backgroundColor = backgroundColor.cgColor
		}
	}
	
	public var frequency = Reporter.Frequency.normally {
		didSet {
			reporter.frequency = frequency
		}
	}
	
	
	// MARK: Initialize
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		
		// TODO:
	}
	
	required init?(coder decoder: NSCoder) {
		super.init(coder: decoder)
		
		guard Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, topLevelObjects: nil) else {
			return
		}
		
		initOutlet()
	}
	
	func initOutlet() {
		wantsLayer = true
		
		backgroundColor = NSColor.black
		textColor = NSColor.white
		initTextField()
	}
	
}


// MARK: SysInfo Reporter Delegate
extension ReporterView {
	
	func reporter(_ manager: Reporter, didUpdate data: Reporter.Data) {
		DispatchQueue.main.async {
			self.updateTextField(data)
			
			
			guard let delegate = self.delegate else {
				return
			}
			
			delegate.reporter(self.reporter, didUpdate: data)
		}
	}
	
}


// MARK: Control
extension ReporterView {
	
	public func start() {
		reporter.start()
		reporter.delegate = self
	}
	
	public func stop() {
		reporter.stop()
		reporter.delegate = nil
	}
	
}



// MARK: TextField
extension ReporterView {
	
	private func initTextField() {
		textFieldOSHeader.stringValue = "# OS"
		textFieldOSMemoryMax.stringValue = "- Max Memory: "
		textFieldOSMemory.stringValue = "- Memory: "
		textFieldOSCPU.stringValue = "- CPU: "
		
		textFieldProcessHeader.stringValue = "# Process"
		textFieldProcessMemory.stringValue = "- Memory: "
		textFieldProcessCPU.stringValue = "- CPU: "
	}
	
	private func textFieldArray() -> [NSTextField] {
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
	
	private func updateTextField(_ data: Reporter.Data) {
		textFieldOSMemoryMax.stringValue = "Memory Max: \(data.osMemory.physicalSize.memoryByteFormatString)"
		textFieldOSMemory.stringValue = "Memory: \(data.osMemory.usedSize.memoryByteFormatString)"
		textFieldOSCPU.stringValue = String(format: "CPU: %.2f%%", 1.0 - data.osCPU.idleUsage)
		
		textFieldProcessMemory.stringValue = "Memory: \(data.processMemory.residentSize.memoryByteFormatString)"
		textFieldProcessCPU.stringValue = String(format: "CPU: %.2f%%", 1.0 - data.processCPU.usage)
	}
	
}
