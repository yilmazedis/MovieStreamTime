//
//  GenresInteractor.swift
//  MoviesStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import Foundation

protocol GenresInteractorProtocol {
    var presenter: GenresPresenterProtocol? { get set }
    
    func fetchData()
}

final class GenresInteractor: GenresInteractorProtocol {
    var presenter: GenresPresenterProtocol?

    func fetchData() {
            
       let queries = [
            "api_key": K.TMDB.token,
            "language": "en-US"
       ]
        
        let urlStr = K.TMDB.url + K.TMDB.listCategory
        let url = urlStr.composeURL(queries: queries)
        
        TMDbManager.shared.fetch(with: url) { [weak self] (result: Result<Genres, Error>) in
            switch result {
            case .success(let genres):
                
                self?.presenter?.dataFetched(data: genres.genres)
                
            case .failure(let error):
                Logger.log(what: "Fetching Genress Failure", over: error)
            }
        }
    }
}
