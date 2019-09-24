//
//  FirebaseClient.swift
//  CineScribe
//
//  Created by Jeffrey Santana on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import Firebase

class FirebaseClient {
	
	let rootRef = Database.database().reference()
	let userRef: DatabaseReference
	let reviewRef: DatabaseReference
	var currentUser: User?
	var userReviews: [Review]?
	
	init() {
		userRef = rootRef.child("users")
		reviewRef = rootRef.child("reviews")
	}
	
	//MARK: - Create
	
	func createUser(username: String, password: String, completion: @escaping () -> Void) {
		guard userRef.child(username).key == nil else { return }
		let newUser = User(username: username, password: password)
		
		currentUser = newUser
		userRef.child(newUser.username).setValue(newUser.toDictionary())
		completion()
	}
	
	//MARK: - Read
	
	func loginUser(username: String, password: String, completion: @escaping () -> Void) {
		userRef.child(username).observeSingleEvent(of: .value) { snapshot in
			let user = User(snapshot: snapshot)
			self.currentUser = user
			completion()
		}
	}
	
	func getReviews() {
		guard let user = currentUser else { return }
		reviewRef.child(user.id.uuidString).observeSingleEvent(of: .value) { snapshot in
			var reviews = [Review]()
			for child in snapshot.children {
				if let snap = child as? DataSnapshot,
					let review = Review(snapshot: snap) {
						reviews.append(review)
				}
			}
			self.userReviews = reviews
		}
	}
	
	//MARK: - Update
	
	func putReview(title: String, hasWatched: Bool, movieId: Int, memorableQuotes: String?, sceneDescription: String?, actorNotes: String?, cinematographyNotes: String?, completion: @escaping () -> Void) {
		guard let user = currentUser else { return }
		let newReview = Review(title: title, movieId: movieId, memorableQuotes: memorableQuotes, sceneDescription: sceneDescription, actorNotes: actorNotes, cinematographyNotes: cinematographyNotes)
		
		reviewRef.child("\(user.id.uuidString)/\(newReview)")
		completion()
	}
		
	//MARK: - Delete
	
	func delete(review: Review, completion: @escaping () -> Void) {
		guard let user = currentUser else { return }
		
		reviewRef.child("\(user.id.uuidString)/\(review.id.uuidString)").removeValue()
		completion()
	}
	
}

#warning("Remove firebase model")
/*
{
	"reviews": {
		"<userUUID>": {
			"<reviewId>": {
				"movieDbId": 12345
			}
		}
	},
	"users": {
		"<userUUID>": {
			"username": "Tom",
			"password": "bs"
		}
	}
}
*/
