//
//  MyCell.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import UIKit

class MyCell: UICollectionViewCell {
    var viewController: UIViewController? {
        didSet {
            guard let viewController = viewController else { return }
            viewController.view.frame = contentView.bounds
            contentView.addSubview(viewController.view)
            
            if let parentViewController = parentViewController {
                parentViewController.addChild(viewController)
                viewController.didMove(toParent: parentViewController)
            }
        }
    }
    
    private var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewController?.willMove(toParent: nil)
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParent()
        viewController = nil
    }
}

