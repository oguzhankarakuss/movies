//
//  BaseResponse.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    var results: [T]?
    var page, totalResults: Int?
    var dates: Dates?
    var totalPages: Int?
    
    public init(results: [T]?,
                page: Int?,
                totalResults: Int?,
                dates: Dates?,
                totalPages: Int?) {
        
        self.results = results
        self.totalResults = totalResults
        self.page = page
        self.dates = dates
        self.totalPages = totalPages
    }
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}

// MARK: - Dates
public struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - OriginalLanguage
public enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case ja = "ja"
    case ru = "ru"
    case fr = "fr"
}
