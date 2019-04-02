// 
//  CrossPlatform.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/04/02.
//  Copyright © 2019 SysInfo. All rights reserved.
//

#if os(iOS)
import UIKit

typealias CrossPlatformRect = CGRect
typealias CrossPlatformColor = UIColor
#elseif os(macOS)
import AppKit

typealias CrossPlatformRect = NSRect
typealias CrossPlatformColor = NSColor
#endif
