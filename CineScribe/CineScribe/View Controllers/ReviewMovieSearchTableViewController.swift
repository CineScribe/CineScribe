//
//  ReviewMovieSearchTableViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class ReviewMovieSearchTableViewController: UIViewController {
	
	//MARK: - IBOutlets
	
	@IBOutlet weak var moviesTableView: UITableView!
	@IBOutlet weak var movieSearchBar: UISearchBar!
	
	//MARK: - Properties
	
	private let movieController = MovieController.shared
	var reviewDelegate: ManageReviewVCDelegate?
	private var searchResults: [Movie] = [] {
		didSet {
			DispatchQueue.main.async {
				self.moviesTableView.reloadData()
			}
		}
	}
	
	//MARK: - Life Cycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		moviesTableView.tableFooterView = UIView()
		moviesTableView.dataSource = self
		movieSearchBar.delegate = self
		
		movieSearchBar.becomeFirstResponder()
    }
	
	//MARK: - IBActions
	
	@IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
		guard let indexPath = moviesTableView.indexPathForSelectedRow else { return }
		let movie = searchResults[indexPath.row]
		reviewDelegate?.setMovieToReview(movie: movie)
		dismiss(animated: true, completion: nil)
	}
	
	//MARK: - Helpers
	

}

// MARK: - SearchBar Delegate

extension ReviewMovieSearchTableViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchQuery = movieSearchBar.text else { return }

		movieController.searchDatabse(for: searchQuery) { (results) in
			do {
				let movies = try results.get()
				self.searchResults = movies
			} catch {
				NSLog("Error fetching movies for search while adding to review: \(error)")
			}
		}
		movieSearchBar.endEditing(true)
	}
}

// MARK: - TableView DataSource

extension ReviewMovieSearchTableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchResults.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? NoteMovieSearchTableViewCell else { return UITableViewCell() }

		cell.tag = indexPath.row

		let movie = searchResults[indexPath.row]
		cell.movie = movie

		return cell
	}
}
