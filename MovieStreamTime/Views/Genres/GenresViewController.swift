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
    
    // MARK: - GenresInteractorProtocol
    var interactor: GenresInteractorProtocol?
    
    // MARK: - Private
    private var data: [Genre] = []
    private var viewControllers = [UIViewController]()
    private let pagingDataSource = GenresViewDataSource()
    
    // MARK: - Private Lazy
    private lazy var pagingCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.carouselLayout())
        view.register(GenresCell.self, forCellWithReuseIdentifier: K.Genres.cell)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagingCollectionView.delegate = pagingDataSource
        pagingCollectionView.dataSource = pagingDataSource
        pagingDataSource.delegate = self
                
        setCollectionViewLayout()
        
        interactor?.fetchData()
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .systemBlue, tintColor: .white, title: K.TMDB.title, preferredLargeTitle: false)
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
            Logger.log(what: K.InfoMessage.noGenre, about: .info)
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
