// 
//  CrossPlatformLabel.swift
//  Baconian
//
//  Created by Daisuke T on 2019/04/03.
//  Copyright © 2019 Baconian. All rights reserved.
//

#if os(iOS)
import UIKit

public typealias CrossPlatformLabel = UILabel

#elseif os(macOS)
import AppKit

open class CrossPlatformLabel: NSTextField {
  open var text: String? {
    get {
      return stringValue
    }
    
    set {
      stringValue = newValue ?? ""
    }
  }
}

#endif
