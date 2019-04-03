// 
//  CrossPlatformSegmentedControl.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/04/03.
//  Copyright © 2019 SysInfo. All rights reserved.
//

#if os(iOS)
import UIKit

open class CrossPlatformSegmentedControl: UISegmentedControl {
	open func addTarget(_ target: Any?, action: Selector) {
		addTarget(target, action: action, for: .valueChanged)
	}
}

#elseif os(macOS)
import AppKit

open class CrossPlatformSegmentedControl: NSSegmentedControl {
	open func addTarget(_ target: Any?, action: Selector) {
		self.target = target as AnyObject?
		self.action = action
	}
}

#endif
