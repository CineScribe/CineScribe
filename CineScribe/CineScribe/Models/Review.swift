//
//  Review.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import Firebase

struct Review {
    let id: UUID
    let dateCreated: Date
    let title: String
	let collectionId: String?
	let movieId: Int?
	var movieImageUrl: URL?
    let memorableQuotes: String?
    let sceneDescription: String?
    let actorNotes: String?
    let cinematographyNotes: String?
	
	init(title: String, movie: Movie?, memorableQuotes: String?, sceneDescription: String?, actorNotes: String?, cinematographyNotes: String?, dateCreated: Date = Date(), id: UUID = UUID()) {
		self.id = id
		self.title = title
		self.dateCreated = dateCreated
		self.collectionId = collectionId?.uuidString
		self.movieId = movie?.id
		self.movieImageUrl = movie?.posterURL
		self.memorableQuotes = memorableQuotes
		self.sceneDescription = sceneDescription
		self.actorNotes = actorNotes
		self.cinematographyNotes = cinematographyNotes
	}
	
	init?(snapshot: DataSnapshot) {
		guard
			let value = snapshot.value as? [String: AnyObject],
			let dateString = value["dateCreated"] as? String,
			let dateCreated = dateString.transformToIsoDate,
			let title = value["title"] as? String else {
				return nil
		}
		
		self.id = UUID(uuidString: snapshot.key) ?? UUID()
		self.dateCreated = dateCreated
		self.title = title
		self.collectionId = value["collectionId"] as? String
		self.movieId = value["movieId"] as? Int
		self.memorableQuotes = value["memorableQuotes"] as? String
		self.sceneDescription = value["sceneDescription"] as? String
		self.actorNotes = value["actorNotes"] as? String
		self.cinematographyNotes = value["cinematographyNotes"] as? String
		
		guard let movieImageUrlString = value["movieImageUrl"] as? String else { return }
		self.movieImageUrl = URL(string: movieImageUrlString)
	}
	
	func toDictionary() -> Any {
		return [
			"dateCreated": dateCreated.transformIsoToString,
			"title": title,
			"collectionId": collectionId as Any,
			"movieId": movieId as Any,
			"movieImageUrl": movieImageUrl?.absoluteString as Any,
			"memorableQuotes": memorableQuotes as Any,
			"sceneDescription": sceneDescription as Any,
			"actorNotes": actorNotes as Any,
			"cinematographyNotes": cinematographyNotes as Any
		]
	}
}
