//
//  Collection.swift
//  CineScribe
//
//  Created by Jeffrey Santana on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import Firebase

struct Collection {
	let id: UUID
	let title: String
	var reviews: [String:Int]
	
	init(id: UUID = UUID(), title: String, reviewIds: [String:Int] = [:]) {
		self.id = id
		self.title = title
		self.reviews = reviewIds
	}
	
	init?(snapshot: DataSnapshot) {
		guard
			let value = snapshot.value as? [String: AnyObject],
			let title = value["title"] as? String else {
				return nil
		}
		let reviewIds = value["reviews"] as? [String:Int]
		
		self.id = UUID(uuidString: snapshot.key) ?? UUID()
		self.title = title
		self.reviews = reviewIds ?? [:]
	}
	
	func toDictionary() -> Any {
		return [
			"title": title,
			"reviews": reviews
		]
	}
}
