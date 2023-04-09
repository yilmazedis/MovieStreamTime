//
//  GenresRouter.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import Foundation

protocol GenresRouterProtocol {
    var entry: GenresEntryPoint? { get }
    
    static func start() -> GenresRouterProtocol
}

final class GenresRouter: GenresRouterProtocol {
    var entry: GenresEntryPoint?
    
    static func start() -> GenresRouterProtocol {
        let router = GenresRouter()
        
        let interactor = GenresInteractor()
        let presenter = GenresPresenter()
        let viewController = GenresViewConroller()
        presenter.view = viewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = viewController as GenresEntryPoint
        
        return router
    }
    
}
