//
//  ListTableViewCell.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

	// MARK: - Outlets & Properties
	@IBOutlet weak var movieArtImageView: UIImageView!
	@IBOutlet weak var listNameLabel: UILabel!
	@IBOutlet weak var listCount: UILabel!




    override func awakeFromNib() {
        super.awakeFromNib()
		setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

	func setUI() {
		movieArtImageView.layer.cornerRadius = 12
	}

}
