//
//  CollectionsModalVC.swift
//  CineScribe
//
//  Created by Jeffrey Santana on 9/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class CollectionsModalVC: UITableViewController {

	// MARK: - IBOutlets
	
	
	// MARK: - Properties
	
	var firebaseClient = FirebaseClient()
	var movie: Movie?
	
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.tableFooterView = UIView()
		
		firebaseClient.getAllCollections {
			self.tableView.reloadData()
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let reviewsModalVC = segue.destination as? ReviewsModalVC, let indexPath = tableView.indexPathForSelectedRow {
			reviewsModalVC.firebaseClient = firebaseClient
			reviewsModalVC.currentCollection = firebaseClient.userCollections[indexPath.row]
			reviewsModalVC.movie = movie
		}
	}
	
	// MARK: - IBActions
	
	
	// MARK: - Helpers
	
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		firebaseClient.userCollections.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath)
		
		cell.textLabel?.text = firebaseClient.userCollections[indexPath.row].title
		
		return cell
	}
}
