// 
//  CrossPlatform.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/04/02.
//  Copyright © 2019 SysInfo. All rights reserved.
//

#if os(iOS)
import UIKit

public typealias CrossPlatformRect = CGRect
public typealias CrossPlatformColor = UIColor
#elseif os(macOS)
import AppKit

public typealias CrossPlatformRect = NSRect
public typealias CrossPlatformColor = NSColor
#endif
