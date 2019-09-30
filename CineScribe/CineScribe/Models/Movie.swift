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
	let tagline: String?
    let runtime: Int?
	let credits: MovieCreditResponse?
	let genres: [MovieGenre]?
	let releaseDateString: String
    let posterPath: String?
	let backdropPath: String?

	var casts: [MovieCastOrCrewMember]? {
		return credits?.cast
	}

	var crews: [MovieCastOrCrewMember]? {
		return credits?.crew
	}

    var releaseDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: releaseDateString)
    }

	var posterURL: URL {
		return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
	}

    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case tagline
        case runtime
        case credits
        case genres
        case releaseDateString = "releaseDate"
        case posterPath
        case backdropPath
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
