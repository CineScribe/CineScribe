//
//  Movie.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

// MARK: - Movie
struct MoviesResponse: Codable {
	let page: Int
	let totalResults: Int
	let totalPages: Int
	let results: [Movie]
}

struct Movie: Codable {
    let id: Int?
    let title: String
    let overview: String
	let releaseDate: String
    let posterPath: String?
	let backdropPath: String?

	var posterURL: URL {
		return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
	}

    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
}

// MARK: - Credits
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
