//
//  CollectionCell.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class CollectionCell: UITableViewCell {

	// MARK: - Outlets & Properties
	 @IBOutlet private weak var movieArtImageView: UIImageView!
	 @IBOutlet private weak var listNameLabel: UILabel!
	 @IBOutlet private weak var listCount: UILabel!
	
	var collection: Collection? {
		didSet {
			setUI()
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
		setUI()
    }

	func setUI() {
		guard let collection = collection else { return }
		
		movieArtImageView.layer.cornerRadius = 12
		listNameLabel.text = collection.title
		listCount.text = "\(collection.reviews.count)"
		
		guard let imageUrl = collection.imageUrl else { return }
		ImageData.shared.fetchImage(with: imageUrl) { (error, fetchedImage) in
			if let error = error {
				NSLog("Error fetching collection image: \(error)")
			}
			self.movieArtImageView.image = fetchedImage
		}
	}
}
