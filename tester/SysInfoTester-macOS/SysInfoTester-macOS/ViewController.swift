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
	@IBOutlet var viewReporter: ReporterCompactView!
	
	@IBOutlet var segmentedControlReporterControl: NSSegmentedControl!
	@IBOutlet var segmentedControlReporterFrequency: NSSegmentedControl!
	
	@IBOutlet var textFieldPressureMemorySize: NSTextField!
	@IBOutlet var textFieldPressureThreadCount: NSTextField!
	@IBOutlet var buttonPressureMemoryAlloc: NSButton!
	@IBOutlet var buttonPressureMemoryDealloc: NSButton!
	@IBOutlet var buttonPressureThreadCreate: NSButton!
	@IBOutlet var buttonPressureThreadDestroy: NSButton!
	
	
	// MARK: Property
	let stress = StressUtility()

	
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
			
		case .stop:
			viewReporter.stop()
		}
	}
	
	
	// MARK: Frequency
	@IBAction func segmentedControlReporterFrequencyValueChanged(_ sender: AnyObject) {
		switch Frequency(rawValue: segmentedControlReporterFrequency.selectedSegment)! {
		case .normally:
			viewReporter.frequency = .normally
			
		case .often:
			viewReporter.frequency = .often
			
		case .veryOften:
			viewReporter.frequency = .veryOften
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

