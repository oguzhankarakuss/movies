//
//  API.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Alamofire

class Service {
    @discardableResult
    private static func performRequest<T:Decodable>(route:Router, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (AFResult<T>)->Void) -> DataRequest {
        
        return AF.request(route).responseDecodable (decoder: decoder) { (response: AFDataResponse<T>) in
            completion(response.result)
        }
    }
    //    MARK: - Upcoming
    static func upcoming(page: Int, completion: @escaping (AFResult<BaseResponse<Upcoming>>)->Void) {
        performRequest(route: .upcoming(page: page), completion: completion)
    }
    
    //    MARK: - NowPlaying
    static func nowPlaying(page: Int, completion: @escaping (AFResult<BaseResponse<NowPlaying>>)->Void) {
        performRequest(route: .nowPlaying(page: page), completion: completion)
    }
    
    //    MARK: - SearchMovie
    static func searchMovie(query: String, page: Int, completion: @escaping (AFResult<BaseResponse<SearchMovie>>)->Void) {
        performRequest(route: .searchMovie(query: query, page: page), completion: completion)
    }
    
    //    MARK: - MoviewDetail
    static func movieDetail(movieId: Int, completion: @escaping (AFResult<MoviewDetail>)->Void) {
        performRequest(route: .movieDetail(movieId: movieId), completion: completion)
    }
    
    //    MARK: - SimilarMovies
    static func similarMovies(movieId: Int, page: Int, completion: @escaping (AFResult<BaseResponse<SimilarMovies>>)->Void) {
        performRequest(route: .similarMovie(movieId: movieId, page: page), completion: completion)
    }
}
