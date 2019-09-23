//
//  Movie.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

struct Movie {
    let id: String
    let title: String
    let overview: String
    let images: URL
    let actors: [String]
    let director: String
    let writer: String
}
