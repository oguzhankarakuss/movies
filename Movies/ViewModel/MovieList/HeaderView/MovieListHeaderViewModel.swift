//
//  MovieListHeaderViewModel.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 18.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation

struct MovieListHeaderViewModel {
    typealias CompletionHandler = (() -> Void)
    weak var dataSource : GenericDataSource<NowPlaying>?
    
    init(dataSource : GenericDataSource<NowPlaying>?) {
        self.dataSource = dataSource
    }
    
    func nowPlaying(with page: Int, completion: CompletionHandler?) {
        Service.nowPlaying(page: page) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let response):
                    if let nowPlaying = response.results {
                        self.dataSource?.data.value = nowPlaying
                    }
            }
        }
    }
}
