//
//  FixedWidthInteger+Baconian.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation

public extension FixedWidthInteger {
    var memoryByteFormatString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(self), countStyle: .memory)
    }
}
