//
//  Extensions.swift
//  CineScribe
//
//  Created by Jeffrey Santana on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

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

extension UIAlertController {
	open override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.view.tintColor = .systemPink
	}
}

extension UITextField {
	var optionalText: String? {
		let trimmedText = self.text?.trimmingCharacters(in: .whitespacesAndNewlines)
		return (trimmedText ?? "").isEmpty ? nil : trimmedText
	}
}
