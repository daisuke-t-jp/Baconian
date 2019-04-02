//
//  ReporterCompactView.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/27.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation
import Cocoa

typealias ReporterCompactViewDelegate = ReporterDelegate

class ReporterCompactView: NSView, ReporterDelegate {
	
	// MARK: Enum, Const
	private static let markOS = "🍎"
	private static let markProcess = "🍏"
	private static let markMemory = "🐏"	// RAM(U+1F40F)
	private static let markCPU = "🤖"
	public static let xibWidth = CGFloat(260)
	public static let xibHeight = CGFloat(50)
	
	
	// MARK: Outlet
	@IBOutlet weak var viewRoot: NSView!
	@IBOutlet weak var textFieldOS: NSTextField!
	@IBOutlet weak var textFieldApp: NSTextField!
	
	
	// MARK: Property
	private let reporter = Reporter()
	weak public var delegate: ReporterCompactViewDelegate?
	
	public var state: Reporter.State {
		return reporter.state
	}
	
	public var textColor = NSColor.white {
		didSet {
			textFieldOS.textColor = textColor
			textFieldApp.textColor = textColor
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
		
		initNib()
		initOutlet()
	}
	
	required init?(coder decoder: NSCoder) {
		super.init(coder: decoder)
		
		initNib()
		initOutlet()
	}
	
	private func initNib() {
		guard Bundle.main.loadNibNamed(String(describing: type(of: self)),
									   owner: self,
									   topLevelObjects: nil) else {
			return
		}
		
		addSubview(viewRoot)
	}
	
	private func initOutlet() {
		wantsLayer = true
		
		backgroundColor = NSColor.black
		textColor = NSColor.white
		
		initTextField()
	}
	
}


// MARK: SysInfo Reporter Delegate
extension ReporterCompactView {
	
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
extension ReporterCompactView {
	
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
extension ReporterCompactView {
	
	private func initTextField() {
		textFieldOS.stringValue = "\(ReporterCompactView.markOS) Waiting..."
		textFieldApp.stringValue = "\(ReporterCompactView.markProcess) Waiting..."
	}
	
	private func updateTextField(_ data: Reporter.Data) {
		textFieldOS.stringValue = stringOS(data)
		textFieldApp.stringValue = stringApp(data)
	}
	
	private func stringOS(_ data: Reporter.Data) -> String {
		return String(format: "%@ | %@ %@ / %@ | %@ %.2f%%",
					  ReporterCompactView.markOS,
					  ReporterCompactView.markMemory,
					  data.osMemory.usedSize.memoryByteFormatString,
					  data.osMemory.physicalSize.memoryByteFormatString,
					  ReporterCompactView.markCPU,
					  data.osCPU.usage * 100)
	}
	
	private func stringApp(_ data: Reporter.Data) -> String {
		return String(format: "%@ | %@ %@ | %@ %.2f%%",
					  ReporterCompactView.markProcess,
					  ReporterCompactView.markMemory,
					  data.processMemory.residentSize.memoryByteFormatString,
					  ReporterCompactView.markCPU,
					  data.processCPU.usage * 100)
	}
	
}
