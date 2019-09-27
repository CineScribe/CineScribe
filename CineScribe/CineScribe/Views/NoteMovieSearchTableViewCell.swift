//
//  NoteMovieSearchTableViewCell.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class NoteMovieSearchTableViewCell: UITableViewCell {

	 @IBOutlet private weak var movieImageView: UIImageView!
	 @IBOutlet private weak var titleLabel: UILabel!

	override func prepareForReuse() {
		super.prepareForReuse()
		movieImageView.image = #imageLiteral(resourceName: "placeholder")
	}

	let imageData = ImageData.shared
	var movie: Movie? {
		didSet {
			updateViews()
		}
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		accessoryType = selected ? .checkmark : .none
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		movieImageView.layer.cornerRadius = 1
		movieImageView.image = #imageLiteral(resourceName: "placeholder")
    }

	private func updateViews() {
		guard let movie = movie else { return }
		titleLabel.text = movie.title

		let rowTag = tag
		imageData.fetchImage(for: movie, imageStyle: .poster) { error, image in
			if let error = error {
				NSLog("Error fetching poster image for movie search while creating a review: \(error)")
			}

			guard let image = image else { fatalError("Could not unwrap image for movie search when creating a review") }
			if self.tag == rowTag {
				self.movieImageView.image = image
			}
		}
	}
}
