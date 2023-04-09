//
//  UICollectionViewLayout+Ext.swift
//  MovieStreamTime
//
//  Created by yilmaz on 9.04.2023.
//

import UIKit

extension UICollectionViewLayout {
    static func carouselLayout() -> UICollectionViewCompositionalLayout {
        // --------- Carousel ---------                                           // make fraction 1 if needs no whitespace
        let carouselItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                     heightDimension: .fractionalHeight(1)))
        carouselItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let carouselGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [carouselItem])

        let carouselSection = NSCollectionLayoutSection(group: carouselGroup)
        carouselSection.orthogonalScrollingBehavior = .groupPagingCentered
        
//        // animation
//        carouselSection.visibleItemsInvalidationHandler = { (items, offset, environment) in
//            items.forEach { item in
//                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
//                let minScale: CGFloat = 0.7
//                let maxScale: CGFloat = 1.1
//                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
//                item.transform = CGAffineTransform(scaleX: scale, y: scale)
//            }
//        }
        let layout = UICollectionViewCompositionalLayout(section: carouselSection)
        return layout
    }

}
