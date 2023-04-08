//
//  GenresPresenter.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import Foundation

protocol GenresPresenterProtocol: AnyObject {
    var view: GenresViewProtocol? { get set }
    
    func dataFetched(data: [Genre])
}

class GenresPresenter: GenresPresenterProtocol {
    weak var view: GenresViewProtocol?

    func dataFetched(data: [Genre]) {
        view?.updateData(data: data)
    }
}
