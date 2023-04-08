//
//  GenresViewController.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import UIKit

typealias GenresEntryPoint = GenresViewProtocol & UIViewController

protocol GenresViewProtocol: AnyObject {
    var interactor: GenresInteractorProtocol? { get set }
    
    func updateData(data: [Genre])
}

final class GenresViewConroller: UIViewController {
    
    var interactor: GenresInteractorProtocol?
    var data: [Genre] = []
    var viewControllers = [UIViewController]()
    
    lazy var pagingCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: getPagingCompositionalLayout())
        view.register(GenresCell.self, forCellWithReuseIdentifier: "PagingCollectionViewCell")
        return view
    }()
    
    private let pagingDataSource = GenresViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        
        pagingCollectionView.delegate = pagingDataSource
        pagingCollectionView.dataSource = pagingDataSource
        pagingDataSource.delegate = self
        
        pagingDataSource.itemSize = pagingCollectionView.bounds.size
        
        setCollectionViewLayout()
        
        interactor?.fetchData()
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .systemBlue, tintColor: .white, title: "Yilmaz", preferredLargeTitle: false)

    }
    
    private func getPagingCompositionalLayout() -> UICollectionViewCompositionalLayout {
        // --------- Carousel ---------                                           // make fraction 1 if needs no whitespace
        let carouselItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                     heightDimension: .fractionalHeight(1)))
        carouselItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 2, trailing: 2)

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

    
    private func setCollectionViewLayout() {
        view.addSubview(pagingCollectionView)
        pagingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pagingCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pagingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pagingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pagingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension GenresViewConroller: GenresViewProtocol {
    func updateData(data: [Genre]) {
        print(data)
        
        guard !data.isEmpty else {
            Logger.log(what: "There are no Genre", about: .info)
            return
        }
    
        DispatchQueue.main.async { [weak self] in
            
            self?.pagingDataSource.data = data
            
            for el in data {
                guard let view = MovieRouter.start(id: el.id).entry else { return }
                view.title = el.name
                
                self?.pagingDataSource.viewControllers.append(view)
            }
            
            self?.pagingCollectionView.reloadData()
        }
    }
}

extension GenresViewConroller: GenresViewDataSourceDelegate {
    func setTitle(name: String) {
        title = name
    }
}
