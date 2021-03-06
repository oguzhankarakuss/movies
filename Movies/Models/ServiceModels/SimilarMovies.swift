//
//  SimilarMovies.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation

// MARK: - SimilarMovies
struct SimilarMovies: Codable {
    let id: Int
    let title, releaseDate: String
    let backdropPath: String?
    let overview, posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case overview
        case posterPath = "poster_path"
    }
}
