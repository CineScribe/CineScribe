//
//  Cast.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

struct Credits: Codable {
	let cast: Cast
	let crew: Crew
}

struct Cast: Codable {
	let castId: Int
	let character: String
	let creditId: String
	let name: String
	let order: Int

	enum CastCodingKeys: String, CodingKey {
		case castId = "cast_id"
		case creditId = "credit_id"
	}
}

struct Crew: Codable {
	let creditId: String
	let job: String
	let name: String
	let department: String

	enum CrewCodingKeys: String, CodingKey {
		case creditId = "credit_id"
	}
}
