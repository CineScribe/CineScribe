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
	@IBOutlet weak var movieArtImageView: UIImageView!
	@IBOutlet weak var listNameLabel: UILabel!
	@IBOutlet weak var listCount: UILabel!
	
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
	}
}
