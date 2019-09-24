//
//  NewNoteViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {


	@IBOutlet weak var noteScrollView: UIScrollView!
	@IBOutlet var noteStackView: UIStackView!
	@IBOutlet weak var reviewTitleLabel: UILabel!
	@IBOutlet weak var movieTitleLabel: UILabel!
	@IBOutlet weak var overviewTextView: UITextView!
	@IBOutlet weak var actingLabel: UILabel!
	@IBOutlet weak var movieInfoStackView: UIStackView!
	@IBOutlet weak var movieInfoContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
		setUI()
    }

	func layoutStackView() {
		noteStackView.leadingAnchor.constraint(equalTo: noteScrollView.leadingAnchor).isActive = true
		noteStackView.topAnchor.constraint(equalTo: noteScrollView.topAnchor).isActive = true
		noteStackView.trailingAnchor.constraint(equalTo: noteScrollView.trailingAnchor).isActive = true
		noteStackView.bottomAnchor.constraint(equalTo: noteScrollView.bottomAnchor).isActive = true
	}

	func setUI() {
		movieInfoContainerView.layer.cornerRadius = 10
		movieInfoContainerView.layer.borderWidth = 1.5
		movieInfoContainerView.layer.borderColor = UIColor.secondaryLabel.cgColor
	}
    



}
