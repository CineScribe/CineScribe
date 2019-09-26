//
//  CastTableViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/25/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class CastTableViewController: UITableViewController {

	let movieController = MovieController.shared
	let imageData = ImageData.shared

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var segControl: UISegmentedControl!

	var cast: [MovieCast] = []
	var crew: [MovieCrew] = []

	var movie: Movie? {
		didSet {
			tableView.reloadData()
			updateViews()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.tableFooterView = UIView()
		tableView.separatorStyle = .none
		updateViews()
		loadCast()
    }

	func loadCast() {
		guard let movie = movie else { return }
		titleLabel.text = movie.title
		movieController.getCredits(with: movie.id) { (results) in
			do {
				let creditResult = try results.get()
				DispatchQueue.main.async {
					self.cast = creditResult.cast
					self.crew = creditResult.crew
					self.tableView.reloadData()
				}
			} catch {
				NSLog("Error getting Cast and Crew results: \(error)")
			}
		}
	}

	private func updateViews() {
		loadViewIfNeeded()
	}

	@IBAction func segControlToggled(_ sender: UISegmentedControl) {
		tableView.reloadData()
	}


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch segControl.selectedSegmentIndex {
		case 0:
			return cast.count
		case 1:
			return crew.count
		default:
			break
		}
        return cast.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell", for: indexPath) as? CastTableViewCell else { return UITableViewCell() }

		cell.tag = indexPath.row

		if segControl.selectedSegmentIndex == 0 {
			let castMember = cast[indexPath.row]

			cell.nameLabel.text = castMember.name
			cell.roleLabel.text = castMember.character

			imageData.fetchImage(for: castMember) { (error, image) in
				if let error = error {
					NSLog("Error fetching image for Cast Member: \(error)")
					return
				}

				guard let image = image else { fatalError("Could not unwrap image for Cast Member") }
				if cell.tag == indexPath.row {
					cell.castImageView.image = image
				}
			}
		} else {

			let crewMember = crew[indexPath.row]

			cell.nameLabel.text = crewMember.name
			cell.roleLabel.text = crewMember.job

			imageData.fetchImage(for: crewMember) { (error, image) in
				if let error = error {
					NSLog("Error fetching image for Cast Member: \(error)")
					return
				}

				guard let image = image else { fatalError("Could not unwrap image for Crew Member") }
				if cell.tag == indexPath.row {
					cell.castImageView.image = image
				}
			}
		}


        return cell
    }

}
