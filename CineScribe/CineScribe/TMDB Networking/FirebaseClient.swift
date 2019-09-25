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
	
	private let rootRef = Database.database().reference()
	private let userRef: DatabaseReference
	private let reviewRef: DatabaseReference
	private let collectionRef: DatabaseReference
	var userCollections = [Collection]()
	var userReviews = [Review]()
	
	#warning("Remove hard-coded user")
	private var currentUser = User(id: UUID(uuidString: "DDF188EF-D391-489B-B254-5B58629E99F6")!, username: "Santana", password: "12345")
	
	init() {
		userRef = rootRef.child("users")
		reviewRef = rootRef.child("reviews")
		collectionRef = rootRef.child("collections")
	}
	
	//MARK: - Create
	
	func createUser(username: String, password: String, completion: @escaping () -> Void) {
		guard userRef.child(username).childByAutoId().key == nil else { return }
		let newUser = User(username: username, password: password)
		
		userRef.child(newUser.username).setValue(newUser.toDictionary())
		currentUser = newUser
		completion()
	}
	
	func createCollection(title: String, completion: @escaping () -> Void) {
		let newCollection = Collection(title: title)
		collectionRef.child(currentUser.id.uuidString).child(newCollection.id.uuidString).setValue(newCollection.toDictionary()) { (error, _) in
			if let error = error {
				NSLog("Error creating collection: \(error)")
			} else {
				completion()
			}
		}
	}
	
	//MARK: - Read
	
	func loginUser(username: String, password: String, completion: @escaping () -> Void) {
		userRef.child(username).observeSingleEvent(of: .value) { snapshot in
//			let user = User(snapshot: snapshot)
//			self.currentUser = user
//			completion()
		}
	}
	
	func getAllCollections(completion: @escaping () -> Void) {
		collectionRef.child(currentUser.id.uuidString).observe(.value, with: { snapshot in
			self.userCollections.removeAll()
					   for child in snapshot.children {
						   if let snap = child as? DataSnapshot,
							   let collection = Collection(snapshot: snap) {
								   self.userCollections.append(collection)
						   }
					   }
			completion()
		}) { error in
			NSLog("Error getting collections: \(error)")
		}
	}
	
	func getAllReviews() {
		reviewRef.child(currentUser.id.uuidString).observeSingleEvent(of: .value) { snapshot in
			self.userReviews.removeAll()
			for child in snapshot.children {
				if let snap = child as? DataSnapshot,
					let review = Review(snapshot: snap) {
						self.userReviews.append(review)
				}
			}
		}
	}
	
	//MARK: - Update
	
	func putReview(title: String, hasWatched: Bool, movieId: Int, collectionId: UUID, memorableQuotes: String?, sceneDescription: String?, actorNotes: String?, cinematographyNotes: String?, completion: @escaping () -> Void) {
		guard let user = currentUser else { return }
		var collection = userCollections?.first(where: {$0.id == collectionId})
		let newReview = Review(title: title, movieId: movieId, memorableQuotes: memorableQuotes, sceneDescription: sceneDescription, actorNotes: actorNotes, cinematographyNotes: cinematographyNotes)
		
		collection?.reviewIds.append(newReview.id.uuidString)
		
		collectionRef.child("\(user.id.uuidString)/\(collectionId)").setValue(collection?.toDictionary())
		reviewRef.child("\(user.id.uuidString)/\(newReview)")
		completion()
	}
		
	//MARK: - Delete
	
	func delete(collection: Collection, completion: @escaping () -> Void) {
	collectionRef.child("\(currentUser.id.uuidString)/\(collection.id.uuidString)").removeValue()
		completion()
	}
	
	func delete(review: Review, completion: @escaping () -> Void) {
		reviewRef.child("\(currentUser.id.uuidString)/\(review.id.uuidString)").removeValue()
		completion()
	}
	
}

#warning("Remove firebase model")
/*
{
	"collections": {
		"<userUUID>": {
			"<collectionUUID>": {
				"title": "<collectionName>",
				"reviews": {
					"<reviewId>": "<movieDbId>",
					"<reviewId>": "<movieDbId>"
				}
			}
		}
	}
	"reviews": {
		"<userUUID>": {
			"<reviewId>": {
				"movieDbId": "<movieDbId>",
				"title": "Plot",
				"collectionId": "<collectionUUID>"
			}
		}
	},
	"users": {
		"<username>": {
			"id": "<userUUID>",
			"password": "<password>"
		}
	}
}
*/
