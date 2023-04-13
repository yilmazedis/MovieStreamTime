//
//  MovieRouter.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import UIKit

protocol MovieRouterProtocol: AnyObject {
    var entry: MovieViewConroller? { get }
    
    func showMovieDetailViewController(movie: Movie)
}

final class MovieRouter: MovieRouterProtocol {
    weak var entry: MovieViewConroller?
    
    func showMovieDetailViewController(movie: Movie) {
        let vc = MovieDetailViewController(movie: movie)
        
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        
        entry?.show(navVc, sender: self)
    }
}
