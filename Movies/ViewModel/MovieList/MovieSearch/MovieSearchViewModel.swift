//
//  MovieSearchViewModel.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 19.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation

final class MovieSearchViewModel {
    typealias CompletionHandler = (() -> Void)
    
    weak var dataSource : GenericDataSource<BaseResponse<MovieList>>?
    private var page = 1
    private var baseMovieList: BaseResponse<MovieList>?
    private var results: [MovieList] = []
    var lastSearchText: String = ""
    var isUpdating = false
    
    init(dataSource : GenericDataSource<BaseResponse<MovieList>>?) {
        self.dataSource = dataSource
    }
    
    final func searchMovie(with text: String) {
        lastSearchText = text
        Service.searchMovie(query: text, page: page) { [weak self] (result) in
            guard let self = self else { return }
            if let dataSource = self.dataSource as? MovieSearchDataSource {
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
            if isUpdating {
                self.results += results
            } else {
                self.results = results
            }
            if var baseMovieList = self.baseMovieList {
                baseMovieList.results = self.results
                dataSource?.data.value = [baseMovieList]
            }
        }
    }
    
    final func updateList(with text: String) {
        if let dataSource = (self.dataSource as? MovieSearchDataSource), let totalPages = dataSource.data.value.first?.totalPages {
            if page < totalPages && text == lastSearchText{
                page += 1
                isUpdating = true
                dataSource.fetchingMore = !(self.dataSource?.data.value.isEmpty ?? false)
                searchMovie(with: text)
            }
        }
    }
    
    final func reset() {
        page = 1
        isUpdating = false
        baseMovieList = nil
        results.removeAll()
        lastSearchText = ""
        dataSource?.data.value = []
    }
}
