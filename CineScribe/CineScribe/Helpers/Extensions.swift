//
//  Extensions.swift
//  CineScribe
//
//  Created by Jeffrey Santana on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

extension Date {
	var transformIsoToString: String {
		let formatter = ISO8601DateFormatter()
		return formatter.string(from: self)
	}
}

extension String {
	var transformToIsoDate: Date? {
		guard self != "" else { return nil }
		let formatter = ISO8601DateFormatter()
		return formatter.date(from: self)
	}
}
