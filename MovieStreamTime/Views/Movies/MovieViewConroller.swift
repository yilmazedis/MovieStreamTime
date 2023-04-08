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
        let view = UICollectionView(frame: .zero, collectionViewLayout: getGroupCompositionalLayout())
        view.register(MovieCell.self, forCellWithReuseIdentifier: "GroupCollectionViewCell")
        return view
    }()
    
    var interactor: MovieInteractorProtocol?
    var id = 28
    private let movieDataSource = MovieViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        interactor?.fetchData(id: id)
        
        groupCollectionView.delegate = movieDataSource
        groupCollectionView.dataSource = movieDataSource
        
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
    
    private func getGroupCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

        //--------- Group 1 ---------//
        let group1Item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        group1Item1.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)


        let nestedGroup1Item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)))
        nestedGroup1Item1.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

         let nestedGroup2Item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        nestedGroup2Item1.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

        let nestedGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)), subitems: [nestedGroup2Item1])

        let nestedGroup1 = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)), subitems: [nestedGroup1Item1, nestedGroup2])

        let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)), subitems: [group1Item1, nestedGroup1])

        //--------- Group 2 ---------//
        let group2Item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
        group2Item1.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)), subitems: [group2Item1])

        //--------- Container Group ---------//
        let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(600)), subitems: [item, group1, group2])

        let section = NSCollectionLayoutSection(group: containerGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension MovieViewConroller: ViewProtocol {
    func updateData(data: [Movie]) {
        print(data)
        
        DispatchQueue.main.async { [weak self] in
            self?.movieDataSource.movie = data
            self?.groupCollectionView.reloadData()
        }
    }
}
