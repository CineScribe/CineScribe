//
//  NoteMovieSearchTableViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

protocol NoteMovieSearchTableViewControllerDelegate: AnyObject {
	func noteMovieSearchTableViewController(_ noteMovieSearchTableViewController: NoteMovieSearchTableViewController, selected movie: Movie)
}

class NoteMovieSearchTableViewController: UIViewController {
	
	 @IBOutlet private weak var moviesTableView: UITableView!
	 @IBOutlet private weak var movieSearchBar: UISearchBar!

	let movieController = MovieController.shared

	weak var delegate: NoteMovieSearchTableViewControllerDelegate?

	var searchResults: [Movie] = [] {
		didSet {
			DispatchQueue.main.async {
				self.moviesTableView.reloadData()
			}
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		moviesTableView.tableFooterView = UIView()
		moviesTableView.delegate = self
		moviesTableView.dataSource = self
		movieSearchBar.delegate = self
    }
    
	@IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: nil)
	}

	@IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
		guard let indexPath = moviesTableView.indexPathForSelectedRow else { return }
		let movie = searchResults[indexPath.row]
		delegate?.noteMovieSearchTableViewController(self, selected: movie)
	}

}

extension NoteMovieSearchTableViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchQuery = movieSearchBar.text else { return }

		movieController.searchDatabse(for: searchQuery) { results in
			do {
				let movies = try results.get()
				self.searchResults = movies
			} catch {
				NSLog("Error fetching movies for search while adding to note: \(error)")
			}
		}
		movieSearchBar.endEditing(true)
	}
}

extension NoteMovieSearchTableViewController: UITableViewDelegate, UITableViewDataSource {
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
