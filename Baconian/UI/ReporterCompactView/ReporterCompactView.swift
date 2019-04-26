//
//  ReporterCompactView.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/27.
//  Copyright © 2019 Baconian. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public typealias ReporterCompactViewDelegate = ReporterDelegate

public class ReporterCompactView: CrossPlatformView, ReporterDelegate {
  
  // MARK: Enum, Const
  private static let symbolOS = "🍎"
  private static let symbolProcess = "🍏"
  private static let symbolMemory = "🐏"	// RAM(U+1F40F)
  private static let symbolCPU = "🤖"
  public static let xibWidth = CGFloat(260)
  public static let xibHeight = CGFloat(50)
  private static let xibName = "ReporterCompactView"
  
  
  // MARK: Outlet
  #if os(macOS)
  @IBOutlet weak var viewTopLevel: CrossPlatformView!
  #endif
  @IBOutlet weak var labelOS: CrossPlatformLabel!
  @IBOutlet weak var labelApp: CrossPlatformLabel!
  
  
  // MARK: Property
  private let reporter = Reporter()
  weak public var delegate: ReporterCompactViewDelegate?
  
  public var state: Reporter.State {
    return reporter.state
  }
  
  public var textColor: CrossPlatformColor? {
    didSet {
      labelOS.textColor = textColor
      labelApp.textColor = textColor
    }
  }
  
  public var frequency = Reporter.Frequency.normally {
    didSet {
      reporter.frequency = frequency
    }
  }
  
  
  // MARK: Initialize
  public override init(frame frameRect: CrossPlatformRect) {
    super.init(frame: frameRect)
    
    initNib()
    initOutlet()
  }
  
  required init?(coder decoder: NSCoder) {
    super.init(coder: decoder)
    
    initNib()
    initOutlet()
  }
  
}


// MARK: Initialize
extension ReporterCompactView {
  
  private func initNib() {
    #if os(iOS)
    let nib = UINib(nibName: ReporterCompactView.xibName,
                    bundle: Bundle(for: ReporterCompactView.self))
    
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? CrossPlatformView else {
      return
    }
    
    addSubview(view)
    #elseif os(macOS)
    guard let nib = NSNib(nibNamed: ReporterCompactView.xibName,
                          bundle: Bundle(for: ReporterCompactView.self)) else {
                            return
    }
    
    guard nib.instantiate(withOwner: self, topLevelObjects: nil) else {
      return
    }
    
    addSubview(viewTopLevel)
    #endif
  }
  
  private func initOutlet() {
    backgroundColor = CrossPlatformColor.black
    textColor = CrossPlatformColor.white
    
    initLabel()
  }
  
}


// MARK: Baconian Reporter Delegate
extension ReporterCompactView {
  
  public func reporter(_ manager: Reporter, didUpdate data: Reporter.Data) {
    DispatchQueue.main.async {
      self.updateLabel(data)
      
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


// MARK: Label
extension ReporterCompactView {
  
  private func initLabel() {
    labelOS.text = "\(ReporterCompactView.symbolOS) Waiting..."
    labelApp.text = "\(ReporterCompactView.symbolProcess) Waiting..."
  }
  
  private func updateLabel(_ data: Reporter.Data) {
    labelOS.text = textOS(data)
    labelApp.text = textApp(data)
  }
  
  private func textOS(_ data: Reporter.Data) -> String {
    return String(format: "%@ | %@ %@ / %@ | %@ %.2f%%",
                  ReporterCompactView.symbolOS,
                  ReporterCompactView.symbolMemory,
                  data.osMemory.usedSize.memoryByteFormatString,
                  data.osMemory.physicalSize.memoryByteFormatString,
                  ReporterCompactView.symbolCPU,
                  data.osCPU.usage * 100)
  }
  
  private func textApp(_ data: Reporter.Data) -> String {
    return String(format: "%@ | %@ %@ | %@ %.2f%%",
                  ReporterCompactView.symbolProcess,
                  ReporterCompactView.symbolMemory,
                  data.processMemory.residentSize.memoryByteFormatString,
                  ReporterCompactView.symbolCPU,
                  data.processCPU.usage * 100)
  }
  
}
