//
//  MoviePresenter.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import Foundation

protocol MoviePresenterProtocol: AnyObject {
    var view: ViewProtocol? { get set }
    
    func dataFetched(data: [Movie])
}

final class MoviePresenter: MoviePresenterProtocol {
    weak var view: ViewProtocol?

    func dataFetched(data: [Movie]) {
        view?.updateData(data: data)
    }
}
