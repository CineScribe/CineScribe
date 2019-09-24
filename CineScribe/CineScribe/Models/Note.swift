//
//  Note.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

struct Note {
    let id: UUID
    let title: String
    let dateCreated: Date
    let hasWatched: Bool
    let memorableQuotes: [String]?
    let sceneDescription: String?
    let actDescription: String?
    let actorNotes: String?
    let cinematographyNotes: String?
}
