//
//  MovieRouter.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import UIKit

protocol MovieRouterProtocol {
    var entry: MovieEntryPoint? { get }
    
    static func start(id: Int) -> MovieRouterProtocol
    func showMovieDetailViewController(movie: Movie)
}

final class MovieRouter: MovieRouterProtocol {
    var entry: MovieEntryPoint?
    
    static func start(id: Int) -> MovieRouterProtocol {
        let router = MovieRouter()
        
        let interactor = MovieInteractor()
        let presenter = MoviePresenter()
        let viewController = MovieViewConroller()
        viewController.id = id
        viewController.router = router
        
        presenter.view = viewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = viewController as MovieEntryPoint
        
        return router
    }
    
    func showMovieDetailViewController(movie: Movie) {
        let vc = MovieDetailViewController(movie: movie)
        
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        
        entry?.show(navVc, sender: self)
    }
}
