// 
//  CrossPlatformButton.swift
//  Baconian
//
//  Created by Daisuke T on 2019/04/03.
//  Copyright © 2019 Baconian. All rights reserved.
//

#if os(iOS)
import UIKit

open class CrossPlatformButton: UIButton {
  open func addTarget(_ target: Any?, action: Selector) {
    addTarget(target, action: action, for: .touchUpInside)
  }
}

#elseif os(macOS)
import AppKit

open class CrossPlatformButton: NSButton {
  open func addTarget(_ target: Any?, action: Selector) {
    self.target = target as AnyObject?
    self.action = action
  }
}

#endif
