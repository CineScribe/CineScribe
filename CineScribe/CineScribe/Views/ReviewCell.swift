//
//  ReviewCell.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {

	// MARK: - Outlets & Properties
	 @IBOutlet private weak var movieArtImageView: UIImageView!
	 @IBOutlet private weak var noteTitleLabel: UILabel!
	
	var review: Review? {
		didSet {
			setUI()
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
		setUI()
    }

	func setUI() {
		guard let review = review else { return }
		
		movieArtImageView.layer.cornerRadius = 12
		noteTitleLabel.text = review.title
		
		guard let imageUrl = review.movieImageUrl else { return }
		ImageData.shared.fetchImage(with: imageUrl) { error, fetchedImage in
			if let error = error {
				NSLog("Error fetching collection image: \(error)")
			}
			self.movieArtImageView.image = fetchedImage
		}
	}
}
