//
//  ViewController.swift
//  SysInfoTester-macOS
//
//  Created by Daisuke T on 2019/03/27.
//  Copyright © 2019 SysInfoTester-macOS. All rights reserved.
//

import Cocoa

// TODO: create storyboard
class ViewController: NSViewController {
	
	// MARK: Enum, Const
	enum Operation: Int {
		case start = 0
		case stop = 1
	}
	
	enum Frequency: Int {
		case normally = 0
		case often = 1
		case veryOften = 2
	}

	
	// MARK: IBOutlet
	@IBOutlet weak var viewReporter: ReporterView!
	@IBOutlet weak var segmentedControlReporterOperation: NSSegmentedControl!
	@IBOutlet weak var segmentedControlReporterFrequency: NSSegmentedControl!
	@IBOutlet weak var buttonPressureMemoryAlloc: NSButton!
	@IBOutlet weak var buttonPressureMemoryDealloc: NSButton!
	@IBOutlet weak var buttonPressureThreadCreate: NSButton!
	@IBOutlet weak var buttonPressureThreadDestroy: NSButton!
	
	
	// MARK: Property
	let tester = Tester()

	
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		segmentedControlReporterOperation.selectedSegment = Operation.stop.rawValue
		segmentedControlReporterOperation.target = self
		segmentedControlReporterOperation.action = #selector(segmentedControlReporterOperationValueChanged(_:))
		
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
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	
	
	// MARK: Operation
	@IBAction func segmentedControlReporterOperationValueChanged(_ sender: AnyObject) {
		switch Operation(rawValue: segmentedControlReporterOperation.selectedSegment)! {
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
		tester.memoryAlloc(1024 * 1024 * 32)
	}
	
	@IBAction func buttonPressureMemoryDeallocTouchUpInside(_ sender: AnyObject) {
		tester.memoryDealloc()
	}
	
	
	// MARK: Thread
	@IBAction func buttonPressureThreadCreateTouchUpInside(_ sender: AnyObject) {
		tester.threadCreate(1024 * 32, sleepInterval: 0.01)
	}
	
	@IBAction func buttonPressureThreadDestroyTouchUpInside(_ sender: AnyObject) {
		tester.threadDestroy()
	}
	
}

