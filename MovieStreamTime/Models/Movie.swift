//
//  MovieInfo.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import Foundation

struct Movies: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let originalTitle: String
    let overview: String
    let releaseDate: String?
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case overview = "overview"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
