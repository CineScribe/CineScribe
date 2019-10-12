//
//  CastTableViewCell.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/25/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class CastTableViewCell: UITableViewCell {

	let imageData = ImageData.shared

	var castMember: MovieCastOrCrewMember? {
		didSet {
			updateViews()
		}
	}

	 @IBOutlet private weak var castImageView: UIImageView!
	 @IBOutlet private weak var nameLabel: UILabel!
	 @IBOutlet private weak var roleLabel: UILabel!

	override func prepareForReuse() {
		super.prepareForReuse()
		castImageView.image = #imageLiteral(resourceName: "placeholder")
	}

	override func awakeFromNib() {
        super.awakeFromNib()
		castImageView.layer.cornerRadius = 4
        castImageView.layer.cornerCurve = .continuous
		castImageView.image = #imageLiteral(resourceName: "placeholder")
    }

	private func updateViews() {
		guard let castMember = castMember else { return }

		nameLabel.text = castMember.name
		roleLabel.text = castMember.character ?? castMember.job ?? "No record"

		let rowTag = tag
		imageData.fetchImage(for: castMember) { error, image in
			if let error = error {
				NSLog("Error fetching image for Cast Member: \(error)")
				return
			}

			guard let image = image else { fatalError("Could not unwrap image for Cast Member") }
			if self.tag == rowTag {
				self.castImageView.image = image
			}
		}
	}
}
