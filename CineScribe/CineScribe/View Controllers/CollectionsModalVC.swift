//
//  CollectionsModalVC.swift
//  CineScribe
//
//  Created by Jeffrey Santana on 9/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class CollectionsModalVC: UITableViewController {

	//MARK: - IBOutlets
	
	
	//MARK: - Properties
	
	var firebaseClient = FirebaseClient()
	var movie: Movie?
	var isNewReview = false
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.tableFooterView = UIView()
		
		firebaseClient.getAllCollections {
			self.tableView.reloadData()
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let indexPath = tableView.indexPathForSelectedRow else { return }
		if let reviewsModalVC = segue.destination as? ReviewsModalVC {
			reviewsModalVC.firebaseClient = firebaseClient
			reviewsModalVC.currentCollection = firebaseClient.userCollections[indexPath.row]
			reviewsModalVC.movie = movie
		} else if let navController = segue.destination as? UINavigationController, let manageReviewVC = navController.children.first as? ManageReviewViewController {
			manageReviewVC.firebaseClient = firebaseClient
			manageReviewVC.currentcollectionId = firebaseClient.userCollections[indexPath.row].id
			
			guard let movie = movie else { return }
			manageReviewVC.reviewType = .newWithMovie(movie)
		}
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		firebaseClient.userCollections.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath)
		
		cell.textLabel?.text = firebaseClient.userCollections[indexPath.row].title
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if isNewReview {
			performSegue(withIdentifier: "SegueToManageReview", sender: nil)
		} else {
			performSegue(withIdentifier: "SegueToReviewsModal", sender: nil)
		}
	}
}
