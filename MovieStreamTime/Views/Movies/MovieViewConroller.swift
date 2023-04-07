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
    
    func updateData(data: [String])
}

class MovieViewConroller: UIViewController {
    
    var interactor: MovieInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }
}

extension MovieViewConroller: ViewProtocol {
    func updateData(data: [String]) {
        
    }
}
