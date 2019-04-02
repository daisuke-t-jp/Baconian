//
//  ViewController.swift
//  SysInfoTester-macOS
//
//  Created by Daisuke T on 2019/03/27.
//  Copyright © 2019 SysInfoTester-macOS. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
	
	// MARK: Enum, Const
	enum Control: Int {
		case start = 0
		case stop = 1
	}
	
	enum Frequency: Int {
		case normally = 0
		case often = 1
		case veryOften = 2
	}

	
	// MARK: IBOutlet
	@IBOutlet weak var viewReporter: ReporterCompactView!
	var viewReporterProgrammatically: ReporterCompactView!
	
	@IBOutlet weak var textFieldViewStoryboard: NSTextField!
	@IBOutlet weak var textFieldViewPragrammatically: NSTextField!

	@IBOutlet weak var segmentedControlReporterControl: NSSegmentedControl!
	@IBOutlet weak var segmentedControlReporterFrequency: NSSegmentedControl!
	
	@IBOutlet weak var textFieldPressureMemorySize: NSTextField!
	@IBOutlet weak var textFieldPressureThreadCount: NSTextField!
	@IBOutlet weak var buttonPressureMemoryAlloc: NSButton!
	@IBOutlet weak var buttonPressureMemoryDealloc: NSButton!
	@IBOutlet weak var buttonPressureThreadCreate: NSButton!
	@IBOutlet weak var buttonPressureThreadDestroy: NSButton!
	
	
	// MARK: Property
	let stress = StressUtility()

	
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewReporterProgrammatically = ReporterCompactView(frame: NSRect(x: 0,
																		 y: 0,
																		 width: ReporterCompactView.xibWidth,
																		 height: ReporterCompactView.xibHeight))
		viewReporterProgrammatically.backgroundColor = .darkGray
		self.view.addSubview(viewReporterProgrammatically)
		
		
		segmentedControlReporterControl.selectedSegment = Control.stop.rawValue
		segmentedControlReporterControl.target = self
		segmentedControlReporterControl.action = #selector(segmentedControlReporterControlValueChanged(_:))
		
		segmentedControlReporterFrequency.selectedSegment = Frequency.normally.rawValue
		segmentedControlReporterFrequency.target = self
		segmentedControlReporterFrequency.action = #selector(segmentedControlReporterFrequencyValueChanged(_:))
		
		buttonPressureMemoryAlloc.target = self
		buttonPressureMemoryAlloc.action = #selector(buttonPressureMemoryAllocTouchUpInside(_:))
		
		buttonPressureMemoryDealloc.target = self
		buttonPressureMemoryDealloc.action = #selector(buttonPressureMemoryDeallocTouchUpInside(_:))
		
		buttonPressureThreadCreate.target = self
		buttonPressureThreadCreate.action = #selector(buttonPressureThreadCreateTouchUpInside(_:))
		
		buttonPressureThreadDestroy.target = self
		buttonPressureThreadDestroy.action = #selector(buttonPressureThreadDestroyTouchUpInside(_:))
		
		updatePressureMemorySizeUpdate()
		updatePressureThreadCountUpdate()
	}
	
	override func viewDidLayout() {
		super.viewDidLayout()
		
		viewReporterProgrammatically.frame.origin.x = viewReporter.frame.origin.x
		viewReporterProgrammatically.frame.origin.y = textFieldViewPragrammatically.frame.origin.y - 10 - viewReporterProgrammatically.frame.height
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	
	
	// MARK: Control
	@IBAction func segmentedControlReporterControlValueChanged(_ sender: AnyObject) {
		switch Control(rawValue: segmentedControlReporterControl.selectedSegment)! {
		case .start:
			viewReporter.start()
			viewReporterProgrammatically.start()
			
		case .stop:
			viewReporter.stop()
			viewReporterProgrammatically.stop()
		}
	}
	
	
	// MARK: Frequency
	@IBAction func segmentedControlReporterFrequencyValueChanged(_ sender: AnyObject) {
		switch Frequency(rawValue: segmentedControlReporterFrequency.selectedSegment)! {
		case .normally:
			viewReporter.frequency = .normally
			viewReporterProgrammatically.frequency = .normally
			
		case .often:
			viewReporter.frequency = .often
			viewReporterProgrammatically.frequency = .often

		case .veryOften:
			viewReporter.frequency = .veryOften
			viewReporterProgrammatically.frequency = .veryOften
		}
	}
	
	
	// MARK: Memory
	@IBAction func buttonPressureMemoryAllocTouchUpInside(_ sender: AnyObject) {
		stress.memoryAlloc(1024 * 1024 * 32)
		updatePressureMemorySizeUpdate()
	}
	
	@IBAction func buttonPressureMemoryDeallocTouchUpInside(_ sender: AnyObject) {
		stress.memoryDealloc()
		updatePressureMemorySizeUpdate()
	}
	
	func updatePressureMemorySizeUpdate() {
		textFieldPressureMemorySize.stringValue = "Memory Size: \(stress.memorySize().memoryByteFormatString)"
	}
	
	
	// MARK: Thread
	@IBAction func buttonPressureThreadCreateTouchUpInside(_ sender: AnyObject) {
		stress.threadCreate(1024 * 32, sleepInterval: 0.01)
		updatePressureThreadCountUpdate()
	}
	
	@IBAction func buttonPressureThreadDestroyTouchUpInside(_ sender: AnyObject) {
		stress.threadDestroy()
		updatePressureThreadCountUpdate()
	}
	
	func updatePressureThreadCountUpdate() {
		textFieldPressureThreadCount.stringValue = "Thread Count: \(stress.threadCount())"
	}

}

