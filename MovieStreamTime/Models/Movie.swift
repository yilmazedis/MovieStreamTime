//
//  MovieInfo.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let original_title: String
    let overview: String
    let release_date: String
    let poster_path: String
    let backdrop_path: String?
}
