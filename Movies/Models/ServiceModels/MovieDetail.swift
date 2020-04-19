//
//  MoviewDetail.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct MovieDetail: Codable {
    let backdropPath: String?
    let id: Int?
    let imdbID, overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case imdbID = "imdb_id"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}


// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
