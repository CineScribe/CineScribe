//
//  User.swift
//  CineScribe
//
//  Created by Jeffrey Santana on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import Firebase

struct User {
	let id: UUID
	let username: String
	let password: String
	
	init(username: String, password: String, id: UUID = UUID()) {
		self.id = id
		self.username = username
		self.password = password
	}
	
	init?(snapshot: DataSnapshot) {
		guard
			let value = snapshot.value as? [String: AnyObject],
			let id = value["id"] as? String,
			let password = value["password"] as? String else {
						   return nil
		}
		
		self.id = UUID(uuidString: id) ?? UUID()
		self.username = snapshot.key
		self.password = password
	}
	
	func toDictionary() -> Any {
		return [
			"id": id,
			"password": password
		]
	}
}
