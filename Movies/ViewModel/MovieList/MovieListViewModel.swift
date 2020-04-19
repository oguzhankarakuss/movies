//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation

final class MovieListViewModel {
    typealias CompletionHandler = (() -> Void)
    
    weak var dataSource : GenericDataSource<BaseResponse<MovieList>>?
    private var page = 1
    private var baseMovieList: BaseResponse<MovieList>?
    private var results: [MovieList] = []
    
    init(dataSource : GenericDataSource<BaseResponse<MovieList>>?) {
        self.dataSource = dataSource
    }
    
    final func getUpcoming(with page: Int, completion: CompletionHandler?) {
        Service.upcoming(page: page) { [weak self] (result) in
            guard let self = self else { return }
            if let dataSource = self.dataSource as? MovieListDataSource {
                switch result {
                case .failure(let error):
                    print(error)
                    dataSource.fetchingMore = false
                case .success(let response):
                    self.handleSuccessBusiness(response)
                    dataSource.fetchingMore = false
                }
            }
        }
    }
    
    private final func handleSuccessBusiness(_ response: BaseResponse<MovieList>) {
        if let results = response.results {
            self.baseMovieList = response
            self.results += results
            if var baseUpcoming = self.baseMovieList {
                baseUpcoming.results = self.results
                dataSource?.data.value = [baseUpcoming]
            }
        }
    }
    
    final func updateList() {
        if let dataSource = (self.dataSource as? MovieListDataSource), let totalPages = dataSource.data.value.first?.totalPages {
            if page < totalPages {
                page += 1
                dataSource.fetchingMore = !(self.dataSource?.data.value.isEmpty ?? false)
                getUpcoming(with: page, completion: nil)
            }
        }
    }
}
