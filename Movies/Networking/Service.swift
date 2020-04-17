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
}
