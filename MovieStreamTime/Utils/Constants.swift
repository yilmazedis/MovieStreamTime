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
        static let key = "68ca79afd1e1e5b9579ef55a2f064725"
        static let posterUrl = "https://image.tmdb.org/t/p/original/"
    }
    
    struct MainScreen {
        static let cell = "mainScreenViewCell"
        static let paginationAmount = 4
        
        static let headerHeight = CGFloat(300)
        static let cellHeight = CGFloat(160)
        
        static let refreshAttribute = "Refreshing"
    }
    
    struct DetailScreen {
        static let titleFont = UIFont.systemFont(ofSize: 20)
        static let descriptionFont = UIFont.systemFont(ofSize: 15)
        static let imdbLineFont = UIFont.systemFont(ofSize: 13)
        
        static let rateLabelColorFrom = 3
        static let rateLabelColorTo = 3
        
        static let rateOver = "/10"
    }
    
    struct HeaderView {
        static let titleFont = UIFont.systemFont(ofSize: 20, weight: .heavy)
        static let descriptionFont = UIFont.systemFont(ofSize: 12, weight: .light)
        
        static let slideshowInterval = 5.0
    }
    
    struct IMDb {
        static let url = "https://www.imdb.com/title/"
    }
    
    struct Color {
        static let overTenRateColor = 0xADB5BD
    }
    
    struct Date {
        static let format = "yyyy-MM-dd HH:mm:ss"
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
    }
}
