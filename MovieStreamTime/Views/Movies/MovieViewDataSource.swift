//
//  MovieViewDataSource.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import UIKit

class MovieViewDataSource: UICollectionViewFlowLayout {
    
    var movie: [Movie] = []
    var viewControllers = [UIViewController]()
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
}


extension MovieViewDataSource: UICollectionViewDelegateFlowLayout {
    
}

extension MovieViewDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCollectionViewCell", for: indexPath) as? MovieCell else { return UICollectionViewCell() }

        
        cell.downloadImage(model: movie[indexPath.item])
        
        return cell
      }
}
