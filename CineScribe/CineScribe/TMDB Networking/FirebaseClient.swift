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
	let collectionRef: DatabaseReference
	var currentUser: User?
	var userCollections: [Collection]?
	var userReviews: [Review]?
	
	init() {
		userRef = rootRef.child("users")
		reviewRef = rootRef.child("reviews")
		collectionRef = rootRef.child("collections")
		
		#warning("Remove hard-coded user")
		currentUser = User(id: UUID(uuidString: "DDF188EF-D391-489B-B254-5B58629E99F6")!, username: "Santana", password: "12345")
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
		guard let user = currentUser else { return }
		let newCollection = Collection(title: title)
		
		collectionRef.child(user.id.uuidString).child(newCollection.id.uuidString).setValue(newCollection.toDictionary()) { (error, _) in
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
			let user = User(snapshot: snapshot)
			self.currentUser = user
			completion()
		}
	}
	
	func getAllCollections(completion: @escaping () -> Void) {
		guard let user = currentUser else { return }
		
		collectionRef.child(user.id.uuidString).observe(.value, with: { snapshot in
					   var collections = [Collection]()
					   for child in snapshot.children {
						   if let snap = child as? DataSnapshot,
							   let collection = Collection(snapshot: snap) {
								   collections.append(collection)
						   }
					   }
			self.userCollections = collections
			completion()
		}) { error in
			NSLog("Error getting collections: \(error)")
		}
	}
	
	func getAllReviews() {
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
		guard let user = currentUser else { return }
		
		collectionRef.child("\(user.id.uuidString)/\(collection.id.uuidString)").removeValue()
		completion()
	}
	
	func delete(review: Review, completion: @escaping () -> Void) {
		guard let user = currentUser else { return }
		
		reviewRef.child("\(user.id.uuidString)/\(review.id.uuidString)").removeValue()
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
				"reviewIds": {
					"0": "<reviewId>",
					"1": "<reviewId>"
				}
			}
		}
	}
	"reviews": {
		"<userUUID>": {
			"<reviewId>": {
				"movieDbId": 12345,
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
