//
//  ServiceConstants.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 16.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation
import Alamofire

struct ServiceConstants {
    struct ProductionServer {
        static let baseURL = "https://api.themoviedb.org/3"
        static let apiKey = "531a0d6c7e6b2aca4d80027962fecf64"
    }
    
    struct APIParameterKey {
        static let page = "page"
        static let apiKey = "api_key"
        static let query = "query"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

public enum RequestParameters {
    case body(_:Parameters)
    case url(_:Parameters)
}
