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
    let title: String
    let dateCreated: Date
    let hasWatched: Bool
	let movieId: Int 
    let memorableQuotes: String?
    let sceneDescription: String?
    let actorNotes: String?
    let cinematographyNotes: String?
	
	init(id: UUID = UUID(), title: String, dateCreated: Date = Date(), hasWatched: Bool = false, movieId: Int, memorableQuotes: String?, sceneDescription: String?, actorNotes: String?, cinematographyNotes: String?) {
		self.id = id
		self.title = title
		self.dateCreated = dateCreated
		self.hasWatched = hasWatched
		self.movieId = movieId
		self.memorableQuotes = memorableQuotes
		self.sceneDescription = sceneDescription
		self.actorNotes = actorNotes
		self.cinematographyNotes = cinematographyNotes
	}
	
	init?(snapshot: DataSnapshot) {
		guard
			let value = snapshot.value as? [String: AnyObject],
			let title = value["title"] as? String,
			let dateString = value["dateCreated"] as? String,
			let dateCreated = dateString.transformToIsoDate,
			let hasWatched = value["hasWatched"] as? Bool,
			let movieId = value["movieId"] as? Int else {
				return nil
		}
		
		self.id = UUID(uuidString: snapshot.key) ?? UUID()
		self.title = title
		self.dateCreated = dateCreated
		self.hasWatched = hasWatched
		self.movieId = movieId
		self.memorableQuotes = value["memorableQuotes"] as? String
		self.sceneDescription = value["sceneDescription"] as? String
		self.actorNotes = value["actorNotes"] as? String
		self.cinematographyNotes = value["cinematographyNotes"] as? String
		
		#warning("Remove old code")
//		if
//			let memorableQuotes = value["memorableQuotes"] as? String,
//			let sceneDescription = value["sceneDescription"] as? String,
//			let actorNotes = value["actorNotes"] as? String,
//			let cinematographyNotes = value["cinematographyNotes"] as? String {
//			self.memorableQuotes = memorableQuotes
//			self.sceneDescription = sceneDescription
//			self.actorNotes = actorNotes
//			self.cinematographyNotes = cinematographyNotes
//		}
	}
	
	func toDictionary() -> Any {
		return [
			"title": title,
			"dateCreated": dateCreated,
			"hasWatched": hasWatched,
			"movieId": movieId,
			"memorableQuotes": memorableQuotes as Any,
			"sceneDescription": sceneDescription as Any,
			"actorNotes": actorNotes as Any,
			"cinematographyNotes": cinematographyNotes as Any
		]
	}
}
