//
//  ReporterView.swift
//  SysInfo-macOS
//
//  Created by Daisuke T on 2019/03/27.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation
import Cocoa

typealias ReporterViewDelegate = ReporterDelegate

class ReporterView: NSView, ReporterDelegate {
	
	// MARK: Outlet
	@IBOutlet var viewRoot: NSView!
	@IBOutlet var textFieldOS: NSTextField!
	@IBOutlet var textFieldApp: NSTextField!
	
	
	// MARK: Property
	private let reporter = Reporter()
	weak public var delegate: ReporterViewDelegate?
	
	public var state: Reporter.State {
		return reporter.state
	}
	
	public var textColor = NSColor.white {
		didSet {
			textFieldOS.textColor = textColor
			textFieldApp.textColor = textColor
		}
	}
	
	public var backgroundColor = NSColor.gray {
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
		
		initView()
	}
	
	required init?(coder decoder: NSCoder) {
		super.init(coder: decoder)
		
		initView()
	}
	
	func initView() {
		guard Bundle.main.loadNibNamed(String(describing: type(of: self)),
									   owner: self,
									   topLevelObjects: nil) else {
			return
		}
		
		viewRoot.frame = bounds
		addSubview(viewRoot)
		
		initOutlet()
	}
	
	func initOutlet() {
		wantsLayer = true
		
		backgroundColor = NSColor.gray
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
		textFieldOS.stringValue = "🍎 Waiting..."
		textFieldApp.stringValue = "🍏 Waiting..."
	}
	
	private func updateTextField(_ data: Reporter.Data) {
		textFieldOS.stringValue = stringOS(data)
		textFieldApp.stringValue = stringApp(data)
	}
	
	private func stringOS(_ data: Reporter.Data) -> String {
		return String(format: "🍎 | 🐏 %@/%@ | 🤖%.2%%",
					  data.osMemory.usedSize.memoryByteFormatString,
					  data.osMemory.physicalSize.memoryByteFormatString,
					  (1.0 - data.osCPU.idleUsage) * 100)
	}
	
	private func stringApp(_ data: Reporter.Data) -> String {
		return String(format: "🍏 | 🐏 %@ | 🤖%.2%%",
					  data.processMemory.residentSize.memoryByteFormatString,
					  data.processCPU.usage)
	}
	
}
