//
//  ViewController.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import UIKit

typealias MovieEntryPoint = ViewProtocol & UIViewController

protocol ViewProtocol: AnyObject {
    var interactor: MovieInteractorProtocol? { get set }
    var id: Int { get set }
    
    func updateData(data: [Movie])
}

class MovieViewConroller: UIViewController {
    
    lazy var groupCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(MovieCell.self, forCellWithReuseIdentifier: "GroupCollectionViewCell")
        return view
    }()
    
    var interactor: MovieInteractorProtocol?
    var id = 0
    private let movieDataSource = MovieViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        interactor?.fetchData(id: id, page: 1)
        
        groupCollectionView.delegate = movieDataSource
        groupCollectionView.dataSource = movieDataSource
        groupCollectionView.collectionViewLayout = movieDataSource
        movieDataSource.delegate = self
        
        setCollectionViewLayout()
    }
    
    private func setCollectionViewLayout() {
        view.addSubview(groupCollectionView)
        groupCollectionView.translatesAutoresizingMaskIntoConstraints = false
        groupCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        groupCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        groupCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        groupCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension MovieViewConroller: ViewProtocol {
    func updateData(data: [Movie]) {
        print(data)
        
        DispatchQueue.main.async { [weak self] in
            
            
            let newItems = data

            // Calculate the index paths of the new items based on the current count
            guard let startIndex = self?.groupCollectionView.numberOfItems(inSection: 0) else { return }
            let endIndex = startIndex + newItems.count - 1
            let indexPaths = (startIndex...endIndex).map { IndexPath(item: $0, section: 0) }

            self?.movieDataSource.movie.append(contentsOf: data)
            // Insert the new items to the collection view
            self?.groupCollectionView.performBatchUpdates({
                self?.groupCollectionView.insertItems(at: indexPaths)
            }, completion: nil)
        }
    }
}

extension MovieViewConroller: MovieViewDataSourceDelegate {
    func fetchData(page: Int) {
        interactor?.fetchData(id: id, page: page)
    }
}
