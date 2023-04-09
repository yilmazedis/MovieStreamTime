//
//  MovieViewDataSource.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import UIKit

protocol MovieViewDataSourceDelegate: AnyObject {
    func fetchData(page: Int)
    func selectedMovie(with movie: Movie)
}

final class MovieViewDataSource: UICollectionViewFlowLayout {
    
    weak var delegate: MovieViewDataSourceDelegate?
    
    var movie: [Movie] = []
    var viewControllers = [UIViewController]()
    
    let itemsPerRow = 3
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 0, right: 10.0)
    private var currentPage = 1
    
    override init() {
        super.init()
        scrollDirection = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // You can use others, up to you
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Check if the user has scrolled to the bottom of the collection view
        let contentHeight = scrollView.contentSize.height
        let yOffset = scrollView.contentOffset.y
        let height = scrollView.frame.height
        if yOffset + height > contentHeight - 150 {
            // Increment the page number and make another network call to fetch the data
            currentPage += 1
            delegate?.fetchData(page: currentPage)
            FastLogger.log(what: K.InfoMessage.paginationLength, about: .info)            
        }
    }
}

extension MovieViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem + 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension MovieViewDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Movies.cell, for: indexPath) as? MovieCell else { return UICollectionViewCell() }
        
        cell.configure(model: movie[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedMovie(with: movie[indexPath.item])
    }
}
