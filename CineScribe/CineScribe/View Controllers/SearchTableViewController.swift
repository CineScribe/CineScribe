//
//  SearchTableViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

protocol SearchTableViewControllerDelegate: AnyObject {
	func searchTableViewController(_ searchTableViewController: SearchTableViewController, hasResults: Bool)
}

class SearchTableViewController: UITableViewController {

	var searchedMovies: [Movie] = [] {
		didSet {
			DispatchQueue.main.async {
				if self.searchedMovies.count > 0 {
					self.delegate?.searchTableViewController(self, hasResults: true)
				} else {
					self.delegate?.searchTableViewController(self, hasResults: false)
				}
				self.tableView.reloadData()
			}
		}
	}

	let movieController = MovieController.shared
	weak var delegate: SearchTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.tableFooterView = UIView()
		tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchedMovies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSearchCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }

		cell.tag = indexPath.row

		let movie = searchedMovies[indexPath.row]
		cell.movie = movie

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchTableViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchQuery = searchBar.text,
			!searchQuery.isEmpty else { return }

		movieController.searchDatabse(for: searchQuery) { (results) in
			do {
				let searchedResults = try results.get()
				self.searchedMovies = searchedResults
			} catch {
				NSLog("Error fetching results for search query: \(error)")
			}
		}
		searchBar.endEditing(true)
	}
}
