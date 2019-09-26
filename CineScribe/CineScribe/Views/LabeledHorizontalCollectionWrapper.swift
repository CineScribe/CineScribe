//
//  LabeledHorizontalCollectionView.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

protocol LabeledHorizontalCollectionWrapperDelegate {
	func labeledCollectionShowDetail(_ collection: LabeledHorizontalCollectionWrapper, for movie: Movie)
}

class LabeledHorizontalCollectionWrapper: UIView {

	@IBOutlet var contentView: UIView!
	@IBOutlet weak var moviesDiscoverCollectionView: UICollectionView!
	@IBOutlet weak var collectionViewTitle: UILabel!

	let imageData = ImageData.shared

	var movies: [Movie] = [] {
		didSet {
			DispatchQueue.main.async {
				self.moviesDiscoverCollectionView.reloadData()
			}
		}
	}

	var movie: Movie?

	var delegate: LabeledHorizontalCollectionWrapperDelegate?

	var title: String {
		get { return collectionViewTitle.text ?? "" }
		set { collectionViewTitle.text = newValue }
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}


	private func commonInit() {
		let nib = UINib(nibName: "LabeledHorizontalCollectionWrapper", bundle: nil)
		nib.instantiate(withOwner: self, options: nil)
		addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

		moviesDiscoverCollectionView.register(MovieDiscoverCollectionViewCell.self, forCellWithReuseIdentifier: "DiscoverCell")

		moviesDiscoverCollectionView.delegate = self
		moviesDiscoverCollectionView.dataSource = self
	}
}

extension LabeledHorizontalCollectionWrapper: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		movies.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath)
		guard let discoverCell = cell as? MovieDiscoverCollectionViewCell else { return cell }
		let movie = movies[indexPath.item]
		discoverCell.movieTitleLabel.text = movie.title
		discoverCell.tag = indexPath.item

		imageData.fetchImage(for: movie, imageStyle: .poster) { (error, image) in
			if let error = error {
				NSLog("Error getting character image: \(error)")
			}

			guard let image = image else { fatalError("Could not unwrap movie poster image") }
			if cell.tag == indexPath.item {
				discoverCell.movieImageView.image = image
			}
		}
		return discoverCell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 180, height: 240)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let movie = movies[indexPath.item]
		delegate?.labeledCollectionShowDetail(self, for: movie)
	}
}
