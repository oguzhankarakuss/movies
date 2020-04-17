//
//  APIRouter.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 16.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case nowPlaying(page: Int)
    case upcoming(page: Int)
    case searchMovie(page: Int)
    case movieDetail(movieId: String)
    case similarMovie(movieId: String, page: Int)
}
    
extension Router {
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .nowPlaying,
             .movieDetail,
             .upcoming,
             .searchMovie,
             .similarMovie:
            return .get
    }
}
    // MARK: - Path
    private var path: String {
            switch self {
            case .nowPlaying:
                return "/movie/now_playing"
            case .movieDetail(let movieId):
                return "“movie/\(movieId)"
            case .upcoming:
                return "/movie/upcoming"
            case .searchMovie:
                return "/search/movie"
            case .similarMovie(let movieId):
                return "movie/\(movieId)/similar"
                
        }
    }
    
    // MARK: - Parameters
    private var parameters: RequestParameters {
        var params: Parameters = [ServiceConstants.APIParameterKey.apiKey: ServiceConstants.ProductionServer.apiKey]
            switch self {
            case .nowPlaying(let page),
                 .upcoming(let page),
                 .searchMovie(let page):
                 params[ServiceConstants.APIParameterKey.page] = page
            case .similarMovie(let page):
                params[ServiceConstants.APIParameterKey.page] = page
            case .movieDetail:
                return .url(params)
        }
        return .url(params)
    }
    
    // MARK: - Encoding
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try ServiceConstants.ProductionServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
         
        switch parameters {
        case .body(let params):
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        case .url(let params):
                let queryParams = params.map { pair  in
                    return URLQueryItem(name: pair.key, value: "\(pair.value)")
                }
                var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                components?.queryItems = queryParams
                urlRequest.url = components?.url
        }
        return urlRequest
    }
}
