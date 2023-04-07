//
//  MoviePresenter.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import Foundation

protocol MoviePresenterProtocol: AnyObject {
    var view: ViewProtocol? { get set }
    
    func dataFetched(data: [String])
}

class MoviePresenter: MoviePresenterProtocol {
    weak var view: ViewProtocol?

    func dataFetched(data: [String]) {
        view?.updateData(data: data)
    }
}
