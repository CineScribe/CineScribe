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

	override func viewDidLoad() {
        super.viewDidLoad()

		searchScrollView.addSubview(searchStackView)
		searchStackView.translatesAutoresizingMaskIntoConstraints = false
		searchStackView.leadingAnchor.constraint(equalTo: searchScrollView.leadingAnchor).isActive = true
		searchStackView.topAnchor.constraint(equalTo: searchScrollView.topAnchor).isActive = true
		searchStackView.trailingAnchor.constraint(equalTo: searchScrollView.trailingAnchor).isActive = true
		searchStackView.bottomAnchor.constraint(equalTo: searchScrollView.bottomAnchor).isActive = true
		searchStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

		let nowPlayingCollectionView = LabeledHorizontalCollectionWrapper()
		nowPlayingCollectionView.title = "Now Playing"
		searchStackView.addArrangedSubview(nowPlayingCollectionView)
		movieController.nowPlayingMovies { (results) in
			do {
				let movieResults = try results.get()
				nowPlayingCollectionView.movies = movieResults
			} catch {
				NSLog("Error getting movie from result: \(error)")
			}
		}

		let upcomingCollectionView = LabeledHorizontalCollectionWrapper()
		upcomingCollectionView.title = "Upcoming"
		searchStackView.addArrangedSubview(upcomingCollectionView)
		
		let topRatedCollectionView = LabeledHorizontalCollectionWrapper()
		topRatedCollectionView.title = "Top Rated"
		searchStackView.addArrangedSubview(topRatedCollectionView)
    }
    
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let searchVC = segue.destination as? SearchTableViewController {
//			self.searchVC = searchVC
			movieSearchBar.delegate = searchVC
		}
	}
}
