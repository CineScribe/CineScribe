//
//  NoteCollectionViewCell.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {

	// MARK: - Outlets & Properties
	@IBOutlet weak var movieArtImageView: UIView!
	@IBOutlet weak var noteTitleLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		movieArtImageView.layer.cornerRadius = 12
	}

    
}
