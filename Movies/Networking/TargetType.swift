//
//  APIConfiguration.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 16.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation
import Alamofire

public protocol TargetType: URLRequestConvertible {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: RequestParameters? { get }
    var encoding: ParameterEncoding { get }

}
