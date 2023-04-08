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

class GenresInteractor: GenresInteractorProtocol {
    var presenter: GenresPresenterProtocol?

    func fetchData() {
        // fetch data from an external service
        TMDbManager.shared.fetch(with: "https://api.themoviedb.org/3/genre/movie/list?api_key=3bb3e67969473d0cb4a48a0dd61af747&language=en-US") { [weak self] (result: Result<Genres, Error>) in
            switch result {
            case .success(let genres):
                
                self?.presenter?.dataFetched(data: genres.genres)
                
            case .failure(let error):
                Logger.log(what: "Fetching Genress Failure", over: error)
            }
        }
    }
}
