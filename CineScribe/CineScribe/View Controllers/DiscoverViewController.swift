//
//  DiscoverViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

	// MARK: - IBOutlets
	
	 @IBOutlet private weak var movieSearchBar: UISearchBar!
     @IBOutlet private var searchStackView: UIStackView!
	 @IBOutlet private weak var searchScrollView: UIScrollView!
	 @IBOutlet private weak var tableViewContainer: UIView!
	 @IBOutlet private weak var cancelButton: UIBarButtonItem!
	
	// MARK: - Properties
	
	let movieController = MovieController.shared
	
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
        super.viewDidLoad()
		cancelButton.isEnabled = false

		setupViews()
		setupNowPlaying()
		setupUpcoming()
		setupTopRated()
    }
    
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let searchVC = segue.destination as? DiscoverySearchTableViewController {
			movieSearchBar.delegate = searchVC
			searchVC.delegate = self
		}
	}
	
	// MARK: - IBActions
	
	
	// MARK: - Helpers
	
	private func setupViews() {
		searchScrollView.addSubview(searchStackView)
		searchStackView.translatesAutoresizingMaskIntoConstraints = false
		searchStackView.leadingAnchor.constraint(equalTo: searchScrollView.leadingAnchor).isActive = true
		searchStackView.topAnchor.constraint(equalTo: searchScrollView.topAnchor).isActive = true
		searchStackView.trailingAnchor.constraint(equalTo: searchScrollView.trailingAnchor).isActive = true
		searchStackView.bottomAnchor.constraint(equalTo: searchScrollView.bottomAnchor).isActive = true
		searchStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
	}
	
	private func setupNowPlaying() {
		let nowPlayingCollectionView = LabeledHorizontalCollectionWrapper()
		nowPlayingCollectionView.title = "Now Playing"
		searchStackView.addArrangedSubview(nowPlayingCollectionView)
		movieController.fetchNowPlayingMovies { results in
			do {
				let movieResults = try results.get()
				nowPlayingCollectionView.movies = movieResults
			} catch {
				NSLog("Error getting 'Now Playing' movie from result: \(error)")
			}
		}
		
		nowPlayingCollectionView.delegate = self
	}
	
	private func setupUpcoming() {
		let upcomingCollectionView = LabeledHorizontalCollectionWrapper()
		upcomingCollectionView.title = "Upcoming"
		searchStackView.addArrangedSubview(upcomingCollectionView)
		movieController.fetchUpcomingMovies { results in
			do {
				let upcomingResults = try results.get()
				upcomingCollectionView.movies = upcomingResults
			} catch {
				NSLog("Error getting 'Upcoming Movies' from results: \(error)")
			}
		}
		upcomingCollectionView.delegate = self
	}
	
	private func setupTopRated() {
		let topRatedCollectionView = LabeledHorizontalCollectionWrapper()
		topRatedCollectionView.title = "Top Rated"
		searchStackView.addArrangedSubview(topRatedCollectionView)
		movieController.fetchTopRatedMovies { results in
			do {
				let topRatedResults = try results.get()
				topRatedCollectionView.movies = topRatedResults
			} catch {
				NSLog("Error getting 'Top-Rated Movies' from results: \(error)")
			}
		}
		
		topRatedCollectionView.delegate = self
    }

	@IBAction func cancelTapped(_ sender: UIBarButtonItem) {
		tableViewContainer.isHidden = true
		movieSearchBar.text = ""
		movieSearchBar.resignFirstResponder()
		cancelButton.isEnabled = false
	}
}

// MARK: - Horizontal CollectionView Wrapper Delegate

extension DiscoverViewController: LabeledHorizontalCollectionWrapperDelegate {
	func labeledCollectionShowDetail(_ collection: LabeledHorizontalCollectionWrapper, for movie: Movie) {
		let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
		guard let movieDetailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { fatalError("Storyboard setup incorrectly") }
		movieDetailVC.movie = movie
		navigationController?.pushViewController(movieDetailVC, animated: true)
	}
}

// MARK: - Search TableView Delegate

extension DiscoverViewController: DiscoverySearchTableViewControllerDelegate {
	func searchTableViewControllerBeganEditing(_ searchTableViewController: DiscoverySearchTableViewController, beganEditing: Bool) {
		if beganEditing == true {
			cancelButton.isEnabled = true
		} else {
			cancelButton.isEnabled = false
		}
	}


	func searchTableViewController(_ searchTableViewController: DiscoverySearchTableViewController, hasResults: Bool) {
		if hasResults {
            UIView.animate(withDuration: 0.6, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.tableViewContainer.isHidden = false
                self.cancelButton.isEnabled = true
            }, completion: nil)
		} else {
            UIView.animate(withDuration: 0.6, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.tableViewContainer.isHidden = true
                self.cancelButton.isEnabled = false
            }, completion: nil)
		}
	}
}
