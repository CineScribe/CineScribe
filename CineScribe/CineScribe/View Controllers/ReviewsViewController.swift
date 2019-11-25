//
//  ReviewsViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

	// MARK: - IBOutlets
	
	 @IBOutlet private weak var notesCollectionView: UICollectionView!
	
	// MARK: - Properties
	
	var firebaseClient: FirebaseClient?
	var currentCollection: Collection?
	
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		notesCollectionView.dataSource = self
		title = currentCollection?.title
		firebaseClient?.notificationCenter.addObserver(self, selector: #selector(fetchReviews), name: Notification.Name( NotificationNames.newReview.rawValue), object: nil)
		
		fetchReviews()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let navController = segue.destination as? UINavigationController,
			let manageReviewVC = navController.viewControllers.first as? ManageReviewViewController {
			manageReviewVC.firebaseClient = firebaseClient
			manageReviewVC.currentcollectionId = currentCollection?.id
			
			if let indexPath = notesCollectionView.indexPathsForSelectedItems?.first,
				let review = firebaseClient?.userReviews[indexPath.item] {
				manageReviewVC.reviewType = ManageReviewType.existing(review)
			}
		}
	}
	
	// MARK: - IBActions
	
	
	// MARK: - Helpers
	
	@objc private func fetchReviews() {
		guard let collection = firebaseClient?.userCollections.first(where: {$0 == currentCollection}) else { return }
		
		firebaseClient?.getReviews(from: collection, completion: {
			self.notesCollectionView.reloadData()
		})
	}
	
}

extension ReviewsViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		firebaseClient?.userReviews.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as? ReviewCell else { return UICollectionViewCell() }
		
		cell.review = firebaseClient?.userReviews[indexPath.item]

		return cell
	}
}
