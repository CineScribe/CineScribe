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
    let id: Int
    let title: String
    let overview: String
	let credits: MovieCreditResponse?
	let genres: [MovieGenre]?
	let releaseDate: String
    let posterPath: String?
	let backdropPath: String?

	var casts: [MovieCastOrCrewMember]? {
		return credits?.cast
	}

	var crews: [MovieCastOrCrewMember]? {
		return credits?.crew
	}

	var posterURL: URL {
		return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
	}

    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
}

// MARK: - Credits
struct MovieCreditResponse: Codable {
	let cast: [MovieCastOrCrewMember]
	let crew: [MovieCastOrCrewMember]
}

struct MovieCastOrCrewMember: Codable {
	let id: Int
	let name: String
	let profilePath: String?

	let character: String?
	let job: String?

	var profileURL: URL? {
		guard let profilePath = profilePath else {
			return nil
		}
		return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")!
	}
}

// MARK: - Genre
struct MovieGenre: Codable {
	let name: String
}
