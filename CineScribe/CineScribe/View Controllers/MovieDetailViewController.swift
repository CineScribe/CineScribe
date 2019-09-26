//
//  MovieDetailViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/25/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

	// MARK: - Properties & Outlets
	@IBOutlet weak var backdropImageView: UIImageView!
	@IBOutlet weak var posterImageView: UIImageView!
	@IBOutlet weak var fadeView: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var releaseDateLabel: UILabel!
	@IBOutlet weak var overviewLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var newNoteButton: UIButton!
	@IBOutlet weak var castButton: UIButton!

	let imageData = ImageData.shared
	let impactGenerator = UIImpactFeedbackGenerator()
	let selectionGenerator = UISelectionFeedbackGenerator()
	let layer = CAGradientLayer()
	var movie: Movie? {
		didSet {
			updateViews()
		}
	}

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		setUI()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
//		feedback.prepare()
		setUI()
		updateViews()
		title = ""
    }

	@IBAction func newNoteButtonTapped(_ sender: UIButton) {
		let optionController = UIAlertController(title: "Choose if you'd like to create a new note from this movie or add to existing note", message: nil, preferredStyle: .actionSheet)
		let newNoteAction = UIAlertAction(title: "Create New Note", style: .default, handler: nil)
		let addToExistingAction = UIAlertAction(title: "Add To Existing Note", style: .default, handler: nil)
		let cancelActions = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		[newNoteAction, addToExistingAction, cancelActions].forEach { optionController.addAction($0) }
		present(optionController, animated: true, completion: nil)
	}

	@IBAction func backButtonTapped(_ sender: UIButton) {
		navigationController?.popViewController(animated: true)
	}


	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ShowCastModalSegue" {
			guard let castTableVC = segue.destination as? CastTableViewController else { return }
			if let movieToSend = movie {
				castTableVC.movie = movieToSend
			}
		}
	}



	// MARK: - Functions
	private func setUI() {
		fadeView.backgroundColor = .clear
		fadeView.layer.insertSublayer(layer, at: 0)
		layer.frame = fadeView.bounds
		layer.colors = [UIColor.systemBackground.withAlphaComponent(0.0).cgColor, UIColor.systemBackground.cgColor]
		posterImageView.layer.cornerRadius = 6
		posterImageView.layer.shadowColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00).cgColor
		posterImageView.layer.shadowRadius = 16
		posterImageView.layer.shadowOpacity = 0.8
		posterImageView.layer.shadowOffset = .zero
		
		if newNoteButton.isHighlighted || newNoteButton.isSelected {
			newNoteButton.backgroundColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
		} else {
			newNoteButton.backgroundColor = .secondarySystemBackground
		}
		newNoteButton.layer.cornerRadius = newNoteButton.frame.height / 2
		castButton.layer.cornerRadius = castButton.frame.height / 2
		castButton.backgroundColor = .secondarySystemBackground
	}

	private func updateViews() {
		loadViewIfNeeded()
		guard let movie = movie else { fatalError("Movie not set") }
		titleLabel.text = movie.title
		overviewLabel.text = movie.overview
		dateLabel.text = movie.releaseDate

		imageData.fetchImage(for: movie, imageStyle: .poster) { (error, posterImage) in
			if let error = error {
				NSLog("Error getting poster image: \(error)")
			}

			guard let image = posterImage else { fatalError("Could not unwrap movie poster image") }
			self.posterImageView.image = image
		}

		imageData.fetchImage(for: movie, imageStyle: .backdrop) { (error, backdropImage) in
			if let error = error {
				NSLog("Error getting backdrop image: \(error)")
			}

			guard let image = backdropImage else { fatalError("Could not unwrap movie backdrop image") }
			self.backdropImageView.image = image
		}
	}
}
