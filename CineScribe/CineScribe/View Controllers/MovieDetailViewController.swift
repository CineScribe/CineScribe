//
//  MovieDetailViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/25/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

	// MARK: - Properties & Outlets
	@IBOutlet weak var backdropImageView: UIImageView!
	@IBOutlet weak var posterImageView: UIImageView!
	@IBOutlet weak var fadeView: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var releaseDateLabel: UILabel!
	@IBOutlet weak var overviewTextView: UITextView!

	let layer = CAGradientLayer()
	var movie: Movie? {
		didSet {
			updateViews()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setUI()
    }
    

	// MARK: - Functions
	private func setUI() {
		overviewTextView.contentMode = .scaleAspectFit
		overviewTextView.layer.cornerRadius = 10
		overviewTextView.layer.borderWidth = 1.5
		overviewTextView.layer.borderColor = UIColor.secondaryLabel.cgColor
		view.layer.addSublayer(layer)
		layer.colors = [UIColor.systemBackground.withAlphaComponent(0.0).cgColor,
						UIColor.systemBackground.cgColor]
		posterImageView.layer.cornerRadius = 10
		posterImageView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.8).cgColor
		posterImageView.layer.shadowRadius = 12
		posterImageView.layer.shadowOpacity = 0.4
	}

	private func updateViews() {
		loadViewIfNeeded()

	}

}
