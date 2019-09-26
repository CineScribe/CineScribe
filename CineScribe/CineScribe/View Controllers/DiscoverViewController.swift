//
//  DiscoverViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

	@IBOutlet weak var movieSearchBar: UISearchBar!
	@IBOutlet var searchStackView: UIStackView!
	@IBOutlet weak var searchScrollView: UIScrollView!
	//	private var searchVC: SearchTableViewController?

	let movieController = MovieController()

	let nowPlayingCollectionView = LabeledHorizontalCollectionWrapper()
	let upcomingCollectionView = LabeledHorizontalCollectionWrapper()
	let topRatedCollectionView = LabeledHorizontalCollectionWrapper()

	override func viewDidLoad() {
        super.viewDidLoad()

		searchScrollView.addSubview(searchStackView)
		searchStackView.translatesAutoresizingMaskIntoConstraints = false
		searchStackView.leadingAnchor.constraint(equalTo: searchScrollView.leadingAnchor).isActive = true
		searchStackView.topAnchor.constraint(equalTo: searchScrollView.topAnchor).isActive = true
		searchStackView.trailingAnchor.constraint(equalTo: searchScrollView.trailingAnchor).isActive = true
		searchStackView.bottomAnchor.constraint(equalTo: searchScrollView.bottomAnchor).isActive = true
		searchStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true


		nowPlayingCollectionView.title = "Now Playing"
		searchStackView.addArrangedSubview(nowPlayingCollectionView)
		movieController.fetchNowPlayingMovies { (results) in
			do {
				let movieResults = try results.get()
				self.nowPlayingCollectionView.movies = movieResults
			} catch {
				NSLog("Error getting 'Now Playing' movie from result: \(error)")
			}
		}

		nowPlayingCollectionView.delegate = self

		upcomingCollectionView.title = "Upcoming"
		searchStackView.addArrangedSubview(upcomingCollectionView)
		movieController.fetchUpcomingMovies { (results) in
			do {
				let upcomingResults = try results.get()
				self.upcomingCollectionView.movies = upcomingResults
			} catch {
				NSLog("Error getting 'Upcoming Movies' from results: \(error)")
			}
		}
		upcomingCollectionView.delegate = self

		topRatedCollectionView.title = "Top Rated"
		searchStackView.addArrangedSubview(topRatedCollectionView)
		movieController.fetchTopRatedMovies { (results) in
			do {
				let topRatedResults = try results.get()
				self.topRatedCollectionView.movies = topRatedResults
			} catch {
				NSLog("Error getting 'Top-Rated Movies' from results: \(error)")
			}
		}

		topRatedCollectionView.delegate = self
    }
    
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let searchVC = segue.destination as? SearchTableViewController {
//			self.searchVC = searchVC
			movieSearchBar.delegate = searchVC
		}
	}
}

extension DiscoverViewController: LabeledHorizontalCollectionWrapperDelegate {
	func labeledCollectionShowDetail(_ collection: LabeledHorizontalCollectionWrapper, for movie: Movie) {
		let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
		guard let movieDetailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { fatalError("Storyboard setup incorrectly") }
		movieDetailVC.movie = movie
		navigationController?.pushViewController(movieDetailVC, animated: true)
		navigationController?.navigationBar.isHidden = true
	}
}
