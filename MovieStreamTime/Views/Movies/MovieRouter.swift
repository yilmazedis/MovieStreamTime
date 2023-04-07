//
//  MovieRouter.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import Foundation

protocol MovieRouterProtocol {
    var entry: MovieEntryPoint? { get }
    
    static func start() -> MovieRouterProtocol
}

class MovieRouter: MovieRouterProtocol {
    var entry: MovieEntryPoint?
    
    static func start() -> MovieRouterProtocol {
        let router = MovieRouter()
        
        let interactor = MovieInteractor()
        let presenter = MoviePresenter()
        let viewController = MovieViewConroller()
        presenter.view = viewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = viewController as MovieEntryPoint
        
        return router
    }
    
}
