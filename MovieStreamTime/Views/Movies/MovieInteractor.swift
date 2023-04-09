//
//  MovieInteractor.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import Foundation

protocol MovieInteractorProtocol {
    var presenter: MoviePresenterProtocol? { get set }
    
    func fetchData(id: Int, page: Int)
}

final class MovieInteractor: MovieInteractorProtocol {
    var presenter: MoviePresenterProtocol?

    func fetchData(id: Int, page: Int) {
        
        let queries = [
             "api_key": K.TMDB.token,
             "sort_by": "popularity.desc",
             "include_adult": "false",
             "include_video": "false",
             "language": "en-US",
             "page": String(page),
             "with_genres": String(id)
        ]
         
        let urlStr = K.TMDB.url + K.TMDB.movieCategory
         let url = urlStr.composeURL(queries: queries)
        
        TMDbManager.shared.fetch(with: url) { [weak self] (result: Result<Movies, Error>) in
                        
            switch result {
            case .success(let movies):
                self?.presenter?.dataFetched(data: movies.results)
                
            case .failure(let error):
                Logger.log(what: "Fetching Movies Failure", over: error)
            }
        }
    }
}
