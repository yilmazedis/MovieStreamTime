//
//  ViewController.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1),
                       green: .random(in: 0.4...1),
                       blue: .random(in: 0.4...1),
                       alpha: 1)
    }
}


typealias MovieEntryPoint = ViewProtocol & UIViewController

protocol ViewProtocol: AnyObject {
    var interactor: MovieInteractorProtocol? { get set }
    var id: Int { get set }
    
    func updateData(data: [Movie])
}

class MovieViewConroller: UIViewController {
    
    var interactor: MovieInteractorProtocol?
    var id = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random
        // Do any additional setup after loading the view.
        
        //interactor?.fetchData()
    }
}

extension MovieViewConroller: ViewProtocol {
    func updateData(data: [Movie]) {
        print(data)
    }
}
