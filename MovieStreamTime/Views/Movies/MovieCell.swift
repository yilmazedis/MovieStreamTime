//
//  MovieCell.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import UIKit

final class MovieCell: UICollectionViewCell {

    private lazy var imageView: UIImageView = {
       let view = UIImageView()
        return view
    }()
    
    private lazy var movieTitle: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 14, weight: .medium)
        return view
    }()
    
    private var imageDownloader = ImageDownloader()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setLayout()
    }
    
    private func setLayout() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        
        contentView.addSubview(movieTitle)
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

    override func prepareForReuse() {
        imageView.backgroundColor = .clear
        imageView.image = nil
        imageDownloader.cancel()
    }

    func configure(model: Movie) {
        
        movieTitle.text = model.original_title
                
        guard let url = URL(string: "\(K.TMDB.posterUrl)\(model.poster_path)") else {
            return
        }
        
        imageDownloader.downloadPhoto(with: url, completion: { [weak self] (image, isCached) in
            guard let self = self else { return }
            
            if isCached {
                Logger.log(what: K.DebugMessage.fromCache, about: .info)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } else {
                Logger.log(what: K.DebugMessage.fromURL, about: .info)
                UIView.transition(with: self, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }, completion: nil)
            }
        })
    }
}
