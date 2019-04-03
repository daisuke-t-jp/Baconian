//
//  ViewController.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/27.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, ReporterCompactViewDelegate {
	
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
	
	@IBOutlet weak var labelViewStoryboard: CrossPlatformLabel!
	@IBOutlet weak var labelViewPragrammatically: CrossPlatformLabel!
	
	@IBOutlet weak var segmentedControlReporterControl: CrossPlatformSegmentedControl!
	@IBOutlet weak var segmentedControlReporterFrequency: CrossPlatformSegmentedControl!
	
	@IBOutlet weak var labelPressureMemorySize: CrossPlatformLabel!
	@IBOutlet weak var labelPressureThreadCount: CrossPlatformLabel!
	@IBOutlet weak var buttonPressureMemoryAlloc: CrossPlatformButton!
	@IBOutlet weak var buttonPressureMemoryDealloc: CrossPlatformButton!
	@IBOutlet weak var buttonPressureThreadCreate: CrossPlatformButton!
	@IBOutlet weak var buttonPressureThreadDestroy: CrossPlatformButton!
	
	
	// MARK: Property
	let stress = StressUtility()
	
	
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewReporter.delegate = self
		viewReporterProgrammatically = ReporterCompactView(frame: CrossPlatformRect(x: 0,
																					y: 0,
																					width: ReporterCompactView.xibWidth,
																					height: ReporterCompactView.xibHeight))
		viewReporterProgrammatically.backgroundColor = .darkGray
		self.view.addSubview(viewReporterProgrammatically)
		
		
		segmentedControlReporterControl.selectedSegmentIndex = Control.stop.rawValue
		segmentedControlReporterControl.addTarget(self, action: #selector(segmentedControlReporterControlEvent(_:)))
		
		segmentedControlReporterFrequency.selectedSegmentIndex = Frequency.normally.rawValue
		segmentedControlReporterFrequency.addTarget(self, action: #selector(segmentedControlReporterFrequencyEvent(_:)))
		
		buttonPressureMemoryAlloc.addTarget(self, action: #selector(buttonPressureMemoryAllocEvent(_:)))
		buttonPressureMemoryDealloc.addTarget(self, action: #selector(buttonPressureMemoryDeallocEvent(_:)))
		buttonPressureThreadCreate.addTarget(self, action: #selector(buttonPressureThreadCreateEvent(_:)))
		buttonPressureThreadDestroy.addTarget(self, action: #selector(buttonPressureThreadDestroyEvent(_:)))
		
		updatePressureMemorySizeUpdate()
		updatePressureThreadCountUpdate()
	}
	
	override func viewDidLayout() {
		super.viewDidLayout()
		
		viewReporterProgrammatically.frame.origin.x = viewReporter.frame.origin.x
		viewReporterProgrammatically.frame.origin.y = labelViewPragrammatically.frame.origin.y - 10 - viewReporterProgrammatically.frame.height
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	
	
	// MARK: ReporterCompactViewDelegate
	func reporter(_ manager: Reporter, didUpdate data: Reporter.Data) {
		print("data -> \(data)")
	}
	
	
	// MARK: Control
	@IBAction func segmentedControlReporterControlEvent(_ sender: AnyObject) {
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
	@IBAction func segmentedControlReporterFrequencyEvent(_ sender: AnyObject) {
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
	@IBAction func buttonPressureMemoryAllocEvent(_ sender: AnyObject) {
		stress.memoryAlloc(1024 * 1024 * 32)
		updatePressureMemorySizeUpdate()
	}
	
	@IBAction func buttonPressureMemoryDeallocEvent(_ sender: AnyObject) {
		stress.memoryDealloc()
		updatePressureMemorySizeUpdate()
	}
	
	func updatePressureMemorySizeUpdate() {
		labelPressureMemorySize.text = "Memory Size: \(stress.memorySize().memoryByteFormatString)"
	}
	
	
	// MARK: Thread
	@IBAction func buttonPressureThreadCreateEvent(_ sender: AnyObject) {
		stress.threadCreate(1024 * 32, sleepInterval: 0.01)
		updatePressureThreadCountUpdate()
	}
	
	@IBAction func buttonPressureThreadDestroyEvent(_ sender: AnyObject) {
		stress.threadDestroy()
		updatePressureThreadCountUpdate()
	}
	
	func updatePressureThreadCountUpdate() {
		labelPressureThreadCount.text = "Thread Count: \(stress.threadCount())"
	}

}

