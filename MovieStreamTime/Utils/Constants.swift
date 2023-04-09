//
//  Constants.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import UIKit

struct K {
    struct TMDB {
        static let url = "https://api.themoviedb.org/3/"
        static let movieCategory = "discover/movie"
        static let listCategory = "genre/movie/list"
        static let token = "3bb3e67969473d0cb4a48a0dd61af747"
        static let posterUrl = "https://image.tmdb.org/t/p/w200/"
        static let title = "Movies"
        static let videoURL = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
    }
    
    struct Genres {
        static let cell = "PagingCollectionViewCell"
    }
    
    struct Movies {
        static let cell = "GroupCollectionViewCell"
    }
    
    struct Date {
        static let format = "yyyy-MM-dd HH:mm:ss"
    }
    
    struct Cache {
        static let name = "MovieCache"
    }
    
    struct ErrorMessage {
        static let model = "Model is nil"
        static let movieId = "MovieId is nil"
        static let cell = "Cell is nil"
        static let movies = "Movies is nil"
        static let requiredInit = "init(coder:) has not been implemented"
        static let url = "Fail to conver urlStr to url"
    }
    
    struct InfoMessage {
        static let paginationLength = "Pagination length is equal to fetched data length"
        static let refreshPage = "Refresh page"
        static let api = "Fetching data is successed"
        static let noGenre = "There are no Genre"
    }
    
    struct DebugMessage {
        static let fromCache = "Got From Cache"
        static let fromURL = "Got From URL"
    }
}
