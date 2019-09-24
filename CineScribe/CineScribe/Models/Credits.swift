//
//  Cast.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

struct MovieCreditResponse: Codable {
	let cast: [MovieCast]
	let crew: [MovieCrew]
}

struct MovieCast: Codable {
	let character: String
	let name: String
	let profilePath: String?

	var profileURL: URL? {
		guard let profilePath = profilePath else {
			return nil
		}
		return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")!
	}

}

struct MovieCrew: Codable {
	let id: Int
	let job: String
	let name: String
	let department: String
	let profilePath: String?

	var profileURL: URL? {
		guard let profilePath = profilePath else {
			return nil
		}
		return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")!
	}

}
