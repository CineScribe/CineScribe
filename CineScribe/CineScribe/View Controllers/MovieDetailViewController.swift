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

	let imageData = ImageData.shared
	let layer = CAGradientLayer()
	var movie: Movie? {
		didSet {
			updateViews()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setUI()
		updateViews()
		title = ""
    }
    

	// MARK: - Functions
	private func setUI() {
		overviewTextView.contentMode = .scaleAspectFit
		overviewTextView.layer.cornerRadius = 10
		overviewTextView.layer.borderWidth = 1.5
		overviewTextView.layer.borderColor = UIColor.secondaryLabel.cgColor
		fadeView.layer.addSublayer(layer)
		layer.frame = fadeView.bounds
		layer.colors = [UIColor.systemBackground.withAlphaComponent(0.0).cgColor, UIColor.clear.cgColor]
		posterImageView.layer.cornerRadius = 8
	}

	private func updateViews() {
		loadViewIfNeeded()
		guard let movie = movie else { fatalError("Movie not set") }
		titleLabel.text = movie.title
		overviewTextView.text = movie.overview

		imageData.fetchPosterImage(for: movie, imageStyle: .poster) { (error, posterImage) in
			if let error = error {
				NSLog("Error getting poster image: \(error)")
			}

			guard let image = posterImage else { fatalError("Could not unwrap movie poster image") }
			self.posterImageView.image = image
		}

		imageData.fetchPosterImage(for: movie, imageStyle: .backdrop) { (error, backdropImage) in
			if let error = error {
				NSLog("Error getting backdrop image: \(error)")
			}

			guard let image = backdropImage else { fatalError("Could not unwrap movie backdrop image") }
			self.backdropImageView.image = image
		}
	}
}
