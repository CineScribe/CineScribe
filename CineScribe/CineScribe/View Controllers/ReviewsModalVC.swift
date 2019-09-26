//
//  ReviewsModalVC.swift
//  CineScribe
//
//  Created by Jeffrey Santana on 9/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class ReviewsModalVC: UITableViewController {

	//MARK: - IBOutlets
	
	
	//MARK: - Properties
	
	var firebaseClient: FirebaseClient?
	var currentCollection: Collection?
	var movie: Movie?
	private var reviewsWithNoMovie: [Review]?
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.tableFooterView = UIView()
		
		guard let collection = currentCollection else { return }
		firebaseClient?.getReviews(from: collection, completion: {
			self.reviewsWithNoMovie = self.firebaseClient?.userReviews.filter({$0.movieId ?? 0 <= 0})
			self.tableView.reloadData()
		})
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		reviewsWithNoMovie?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)
		
		cell.textLabel?.text = reviewsWithNoMovie?[indexPath.item].title
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let collectionId = currentCollection?.id, let review = reviewsWithNoMovie?[indexPath.row] else { return }
		firebaseClient?.putReview(collectionId: collectionId, reviewId: review.id, title: review.title, movie: movie, memorableQuotes: review.memorableQuotes, sceneDescription: review.sceneDescription, actorNotes: review.actorNotes, cinematographyNotes: review.cinematographyNotes, completion: {
			self.performSegue(withIdentifier: "unwindToMovieDetailVC", sender: nil)
		})
	}
}
