//
//  CustomMovieDetailModel.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 18.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation

struct CustomMovieDetailModel: Codable {
    var headerImageUrl: String?
    var movieDetail: MovieDetail?
    var similarMovies: [SimilarMovies]?
    
    init(headerImageUrl: String?,
         movieDetail: MovieDetail?,
         similarMovies: [SimilarMovies]?) {
        
        self.headerImageUrl = headerImageUrl
        self.movieDetail = movieDetail
        self.similarMovies = similarMovies
    }
}
