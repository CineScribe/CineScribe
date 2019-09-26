//
//  CastTableViewCell.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/25/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class CastTableViewCell: UITableViewCell {



	@IBOutlet weak var castImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var roleLabel: UILabel!

	override func prepareForReuse() {
		super.prepareForReuse()
		castImageView.image = #imageLiteral(resourceName: "placeholder")
	}

	override func awakeFromNib() {
        super.awakeFromNib()
		castImageView.layer.cornerRadius = 4
    }


}
