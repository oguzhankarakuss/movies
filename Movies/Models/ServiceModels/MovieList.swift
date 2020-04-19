//
//  MovieList.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation

// MARK: - MovieList
struct MovieList: Codable {
    let posterPath: String?
    let id: Int
    let backdropPath: String?
    let title: String
    let overview, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case title
        case overview
        case releaseDate = "release_date"
    }
}
