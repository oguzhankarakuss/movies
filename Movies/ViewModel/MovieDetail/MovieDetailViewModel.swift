//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 18.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation

final class MovieDetailViewModel {
    
    typealias CompletionHandler = (() -> Void)
    
    weak var dataSource: MovieDetailDataSource?
    private var movieDetail: MovieDetail?
    
    init(dataSource: MovieDetailDataSource?) {
        self.dataSource = dataSource
    }
    
    final func getMovieDetail(with movieId: Int, completion: CompletionHandler?) {
        Service.movieDetail(movieId: movieId) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                self.setMovieDetail(with: response)
                completion?()
            }
        }
    }
    
    final func getSimilarMovies(with movieId: Int, page: Int) {
        Service.similarMovies(movieId: movieId,
                              page: page) { [weak self] (result) in
                                guard let self = self else { return }
                                switch result {
                                case .failure(let error):
                                    print(error)
                                case .success(let response):
                                    self.setDataSource(with: response)
                                }
        }
    }
    
    private final func setDataSource(with response: BaseResponse<SimilarMovies>) {
        if let similarMovies = response.results {
            self.dataSource?.data.value = [BaseResponse<CustomMovieDetailModel>(results: [CustomMovieDetailModel(headerImageUrl: self.movieDetail?.posterPath,
                                                                                                                 movieDetail: self.movieDetail,
                                                                                                                 similarMovies: similarMovies)],
                                                                                page: response.page,
                                                                                totalResults: response.totalResults,
                                                                                dates: response.dates,
                                                                                totalPages: response.totalResults)]
        }
        
    }
    
    private final func setMovieDetail(with response: MovieDetail) {
        self.movieDetail = response
    }
}
