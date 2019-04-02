// 
//  CrossPlatformView.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/04/03.
//  Copyright © 2019 SysInfo. All rights reserved.
//

#if os(iOS)
import UIKit

public typealias CrossPlatformView = UIView

#elseif os(macOS)
import AppKit

open class CrossPlatformView: NSView {
	open var backgroundColor: CrossPlatformColor? {
		get {
			if !wantsLayer {
				wantsLayer = true
			}
			
			return CrossPlatformColor(cgColor: self.layer?.backgroundColor ?? CrossPlatformColor.clear.cgColor)
		}
		
		set {
			if !wantsLayer {
				wantsLayer = true
			}
			
			layer?.backgroundColor = newValue?.cgColor
		}
	}
}

#endif
