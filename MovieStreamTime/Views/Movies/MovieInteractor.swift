//
//  MovieInteractor.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import Foundation

protocol MovieInteractorProtocol {
    var presenter: MoviePresenterProtocol? { get set }
    
    func fetchData()
}

class MovieInteractor: MovieInteractorProtocol {
    var presenter: MoviePresenterProtocol?

    func fetchData() {
        // fetch data from an external service
        TMDbManager.shared.fetch(with: "https://api.themoviedb.org/3/discover/movie?api_key=3bb3e67969473d0cb4a48a0dd61af747&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=28") { [weak self] (result: Result<Movies, Error>) in
                        
            switch result {
            case .success(let movies):
                self?.presenter?.dataFetched(data: movies.results)
                
            case .failure(let error):
                Logger.log(what: "Fetching Movies Failure", over: error)
            }
        }
    }
}
