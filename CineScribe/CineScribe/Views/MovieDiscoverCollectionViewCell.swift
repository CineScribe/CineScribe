//
//  MovieDiscoverCollectionViewCell.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class MovieDiscoverCollectionViewCell: UICollectionViewCell {


	@IBOutlet var myContentView: UIView!
	@IBOutlet weak var movieImageView: UIImageView!
	@IBOutlet weak var movieTitleContainerView: UIView!
	@IBOutlet weak var movieTitleLabel: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}

	func setStyle() {

	}

	private func commonInit() {
		let nib = UINib(nibName: "MovieDiscoverCollectionViewCell", bundle: nil)
		nib.instantiate(withOwner: self, options: nil)
		addSubview(myContentView)
		myContentView.translatesAutoresizingMaskIntoConstraints = false
		myContentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		myContentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		myContentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		myContentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		myContentView.layer.cornerRadius = 8
		myContentView.clipsToBounds = true
		movieTitleContainerView.backgroundColor = .secondarySystemBackground
	}

}
