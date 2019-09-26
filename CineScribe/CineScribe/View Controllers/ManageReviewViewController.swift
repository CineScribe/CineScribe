//
//  ManageReviewViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class ManageReviewViewController: UIViewController {

	//MARK: - IBOutlets
	
	@IBOutlet weak var titleBtn: UIButton!
	@IBOutlet weak var quotesBtn: UIButton!
	@IBOutlet weak var sceneNotesBtn: UIButton!
	@IBOutlet weak var actorNotesBtn: UIButton!
	@IBOutlet weak var cinemaNotesBtn: UIButton!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var quotesTextView: UITextView!
	@IBOutlet weak var sceneNotesTextView: UITextView!
	@IBOutlet weak var actorNotesTextView: UITextView!
	@IBOutlet weak var cinemaNotesTextView: UITextView!
	@IBOutlet weak var saveBtn: UIBarButtonItem!
	@IBOutlet weak var movieBtn: UIBarButtonItem!
	
	//MARK: - Properties

	private var textBtns = [UIButton]()
	private var textViews = [UITextView]()
	var firebaseClient: FirebaseClient?
	var currentcollectionId: UUID?
	var currentReview: Review?
	var currentMovieId: Int?
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		textBtns = [titleBtn, quotesBtn, sceneNotesBtn, actorNotesBtn, cinemaNotesBtn]
		textViews = [quotesTextView, sceneNotesTextView, actorNotesTextView, cinemaNotesTextView]
		
		setupViews()
	}
	
	//MARK: - IBActions
	
	@IBAction func saveBtnTapped(_ sender: Any) {
		guard let collectionId = currentcollectionId, let title = titleTextField.optionalText else { return }
		firebaseClient?.putReview(collectionId: collectionId, title: title, movieId: currentMovieId, memorableQuotes: quotesTextView.text, sceneDescription: sceneNotesTextView.text, actorNotes: actorNotesTextView.text, cinematographyNotes: cinemaNotesTextView.text, completion: {
			print("Review Saved!")
			self.dismiss(animated: true, completion: nil)
		})
	}
	
	@IBAction func collapsableBtnTapped(_ sender: UIButton) {
		switch sender.tag {
		case 0:
			titleTextField.isHidden.toggle()
		case 1:
			quotesTextView.isHidden.toggle()
		case 2:
			sceneNotesTextView.isHidden.toggle()
		case 3:
			actorNotesTextView.isHidden.toggle()
		case 4:
			cinemaNotesTextView.isHidden.toggle()
		default:
			break
		}
	}
	
	//MARK: - Helpers
	
	private func setupViews() {
		titleTextField.tag = 0
		titleTextField.isHidden = currentReview == nil ? true : false
		
		for index in 0..<textBtns.count {
			textBtns[index].tag = index
		}
		
		for index in 0..<textViews.count {
			textViews[index].tag = index + 1
		}
		
		for index in 0..<textViews.count {
			if currentReview == nil {
				textViews[index].isHidden = true
				textViews[index].text = ""
			}
			textViews[index].layer.borderWidth = 2
			textViews[index].layer.borderColor = UIColor.lightGray.cgColor
			textViews[index].layer.cornerRadius = 10
			textViews[index].layer.masksToBounds = true
		}
		
		if let review = currentReview {
			title = "Review"
			titleTextField.text = review.title
			quotesTextView.text = review.memorableQuotes
			sceneNotesTextView.text = review.sceneDescription
			actorNotesTextView.text = review.actorNotes
			cinemaNotesTextView.text = review.cinematographyNotes
		}
	}
}
