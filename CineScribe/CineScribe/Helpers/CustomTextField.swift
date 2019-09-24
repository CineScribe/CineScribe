//
//  CustomTextField.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class customTextfield: UIView {


	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	let customTextField = UITextField()

	func setupTextField() {
		customTextField.borderStyle = .none
	}

}
