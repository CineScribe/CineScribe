//
//  SearchTableViewCell.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

	var movie: Movie? {
		didSet {
			updateViews()
		}
	}

	@IBOutlet weak var movieArtImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var taglineLabel: UILabel!
	@IBOutlet weak var addButton: UIButton!

	override func prepareForReuse() {
		super.prepareForReuse()
		movieArtImageView.image = UIImage(named: "placeholder")
	}


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


	private func updateViews() {
		guard let movie = movie else { return }
		titleLabel.text = movie.title
		taglineLabel.text = movie.tagline ?? ""
	}
}
