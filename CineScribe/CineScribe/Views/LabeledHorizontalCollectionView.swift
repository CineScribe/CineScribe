//
//  LabeledHorizontalCollectionView.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class LabeledHorizontalCollectionView: UIView {

	@IBOutlet var contentView: UIView!
	@IBOutlet weak var moviesDiscoverCollectionView: UICollectionView!
	@IBOutlet weak var collectionViewTitle: UILabel!

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
		let nib = UINib(nibName: "LabeledHorizontalCollectionView", bundle: nil)
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

extension LabeledHorizontalCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		10
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath)
		guard let discoverCell = cell as? MovieDiscoverCollectionViewCell else { return cell }
		discoverCell.myContentView.backgroundColor = .systemPink
		return discoverCell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 180, height: 180)
	}
}
