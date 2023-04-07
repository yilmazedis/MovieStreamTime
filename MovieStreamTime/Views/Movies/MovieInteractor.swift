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
    weak var presenter: MoviePresenterProtocol?

    func fetchData() {
        // fetch data from an external service
        let data = ["item 1", "item 2", "item 3"]
        presenter?.dataFetched(data: data)
    }
}
