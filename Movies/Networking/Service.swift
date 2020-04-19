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
    private static func performRequest<T:Decodable>(route:Router,
                                                    decoder: JSONDecoder = JSONDecoder(),
                                                    showLoading: Bool = true,
                                                    completion: @escaping (AFResult<T>)->Void) -> DataRequest {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let progressHUD = ProgressHUD()
        if showLoading {
            if let window = keyWindow {
                progressHUD.frame = window.bounds
                window.addSubview(progressHUD)
            }
        }
        
        return AF.request(route).responseDecodable (decoder: decoder) { (response: AFDataResponse<T>) in
            if showLoading {
                progressHUD.removeFromSuperview()
            }
            if response.error != nil {
                if var topController = keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }
                    topController.presentAlert()
                }
            }
            completion(response.result)
        }
    }
    //    MARK: - Upcoming
    static func upcoming(page: Int, completion: @escaping (AFResult<BaseResponse<MovieList>>)->Void) {
        performRequest(route: .upcoming(page: page), completion: completion)
    }
    
    //    MARK: - NowPlaying
    static func nowPlaying(page: Int, completion: @escaping (AFResult<BaseResponse<NowPlaying>>)->Void) {
        performRequest(route: .nowPlaying(page: page), completion: completion)
    }
    
    //    MARK: - SearchMovie
    static func searchMovie(query: String, page: Int, completion: @escaping (AFResult<BaseResponse<MovieList>>)->Void) {
        performRequest(route: .searchMovie(query: query, page: page), showLoading: false, completion: completion)
    }
    
    //    MARK: - MoviewDetail
    static func movieDetail(movieId: Int, completion: @escaping (AFResult<MovieDetail>)->Void) {
        performRequest(route: .movieDetail(movieId: movieId), completion: completion)
    }
    
    //    MARK: - SimilarMovies
    static func similarMovies(movieId: Int, page: Int, completion: @escaping (AFResult<BaseResponse<SimilarMovies>>)->Void) {
        performRequest(route: .similarMovie(movieId: movieId, page: page), completion: completion)
    }
}
