//
//  Genre.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import Foundation

struct Genres: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
