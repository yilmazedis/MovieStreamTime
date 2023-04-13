//
//  MovieConfigurator.swift
//  MovieStreamTime
//
//  Created by yilmaz on 13.04.2023.
//

import Foundation

final class MovieConfigurator {
    static func configure(id: Int, name: String) -> MovieViewConroller {
        let router = MovieRouter()
        let interactor = MovieInteractor()
        let presenter = MoviePresenter()
        let viewController = MovieViewConroller()
        viewController.id = id
        viewController.router = router
        viewController.title = name
        
        presenter.view = viewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = viewController
        
        return viewController
    }
}
