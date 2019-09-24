//
//  Movie.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

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
    let poster: String?
	let backdrop: String?
}
