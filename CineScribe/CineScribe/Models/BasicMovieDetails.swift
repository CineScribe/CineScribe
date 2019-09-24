//
//  BasicMovieDetails.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import Firebase

struct BasicMovieDetails {
	let movieDbId: Int
	let title: String
	let coverImage: URL?
	
	init(id: Int, title: String, coverImage: URL?) {
		self.movieDbId = id
		self.title = title
		self.coverImage = coverImage
	}
	
	init?(snapshot: DataSnapshot) {
		guard
			let value = snapshot.value as? [String: AnyObject],
			let title = value["title"] as? String,
			let movieDbId = value["movieDbId"] as? Int,
			let coverImage = value["movieDbId"] as? URL else {
				return nil
		}
		
		self.title = title
		self.movieDbId = movieDbId
		self.coverImage = coverImage
	}
	
	func toDictionary() -> Any {
		return [
			"movieDBId": movieDbId,
			"title": title,
			"coverImage": coverImage?.absoluteString as Any
		]
	}
}
