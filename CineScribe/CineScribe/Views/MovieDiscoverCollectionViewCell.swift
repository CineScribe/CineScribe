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
	 @IBOutlet private weak var movieImageView: UIImageView!
	 @IBOutlet private weak var movieTitleContainerView: UIView!
	 @IBOutlet private weak var movieTitleLabel: UILabel!

    let imageData = ImageData.shared

    var movie: Movie? {
        didSet {
            updateViews()
        }
    }

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
        updateViews()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
        updateViews()
	}

	func updateViews() {
        guard let movie = movie else { return }

        movieTitleLabel.text = movie.title

        let itemTag = tag
        imageData.fetchImage(for: movie, imageStyle: .poster) { error, image in
            if let error = error {
                NSLog("Error getting character image: \(error)")
                return
            }

            guard let image = image else { fatalError("Could not unwrap movie poster image") }
            if self.tag == itemTag {
                self.movieImageView.image = image
            }
        }
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
