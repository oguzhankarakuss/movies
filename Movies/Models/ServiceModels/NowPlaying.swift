//
//  NowPlaying.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation

// MARK: - NowPlaying
struct NowPlaying: Codable {
    let posterPath: String
    let id: Int?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case title
    }
}
