//
//  GenresViewDataSource.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import UIKit

protocol GenresViewDataSourceDelegate: AnyObject {
    func setTitle(name: String)
}

final class GenresViewDataSource: UICollectionViewFlowLayout {
    
    var data: [Genre] = []
    var viewControllers = [UIViewController]()
    
    weak var delegate: GenresViewDataSourceDelegate?
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GenresViewDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Genres.cell, for: indexPath) as? GenresCell else {
            return UICollectionViewCell()
        }
        
        cell.viewController = viewControllers[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.setTitle(name: viewControllers[indexPath.item].title ?? K.TMDB.title)
    }
}
