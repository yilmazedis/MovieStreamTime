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
    let id: Int
    let original_title: String
    let overview: String
    let release_date: String?
    let poster_path: String
}
