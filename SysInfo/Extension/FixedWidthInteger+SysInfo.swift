//
//  FixedWidthInteger+SysInfo.swift
//  SysInfo
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 SysInfo. All rights reserved.
//

import Foundation

public extension FixedWidthInteger {
	var decialFormatString: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		
		guard let number = (self as? NSNumber) else {
			return "\(self)"
		}
		
		let str = formatter.string(from: number)
		return str ?? "\(self)"
	}
	
	var memoryByteFormatString: String {
		return ByteCountFormatter.string(fromByteCount: Int64(self), countStyle: .memory)
	}
}
