//
//  SearchTableViewCell.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

	let imageData = ImageData.shared

	var movie: Movie? {
		didSet {
			updateViews()
		}
	}

	@IBOutlet weak var movieArtImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var overViewLabel: UILabel!

	override func prepareForReuse() {
		super.prepareForReuse()
		movieArtImageView.image = UIImage(named: "placeholder")
	}

    override func awakeFromNib() {
        super.awakeFromNib()
		movieArtImageView.layer.cornerRadius = 1
		movieArtImageView.image = UIImage(named: "placeholder")
    }

	private func updateViews() {
		guard let movie = movie else { return }
		titleLabel.text = movie.title
		overViewLabel.text = movie.overview

		let rowTag = tag
		imageData.fetchImage(for: movie, imageStyle: .poster) { (error, image) in
			if let error = error {
				NSLog("Error fetching Poster Image for movie in Search Cell: \(error)")
				return
			}

			guard let image = image else { fatalError("Could not unwrap image for movie in Search Cell") }
			if self.tag == rowTag {
				self.movieArtImageView.image = image
			}
		}
	}
}
