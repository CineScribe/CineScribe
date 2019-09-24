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
	var reviewIds: [String]
	
	init(id: UUID = UUID(), title: String, reviewIds: [String] = []) {
		self.id = id
		self.title = title
		self.reviewIds = reviewIds
	}
	
	init?(snapshot: DataSnapshot) {
		guard
			let value = snapshot.value as? [String: AnyObject],
			let title = value["title"] as? String,
			let reviewIds = value["reviewIds"] as? [Int: String] else {
				return nil
		}
		
		self.id = UUID(uuidString: snapshot.key) ?? UUID()
		self.title = title
		self.reviewIds = reviewIds.values.compactMap({$0})
	}
	
	func toDictionary() -> Any {
		return [
			"title": title,
			"reviewIds": reviewIds
		]
	}
}
