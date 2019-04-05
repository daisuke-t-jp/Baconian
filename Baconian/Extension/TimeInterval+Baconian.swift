//
//  TimeInterval+Baconian.swift
//  Baconian
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Baconian. All rights reserved.
//

import Foundation

extension TimeInterval {
	init(_ timeValue: time_value_t) {
		self.init(Double(timeValue.seconds) + (Double(timeValue.microseconds) / Double(USEC_PER_SEC)))
	}
}
