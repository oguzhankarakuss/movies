//
//  MovieSearchTableViewCell.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 19.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

final class MovieSearchTableViewCell: BaseTableViewCell {
    
    var movieList: MovieList? {
        didSet {
            configure()
        }
    }
    
    private final func configure() {
        if let movieList = movieList {
            textLabel?.text = movieList.title
        }
    }
}
