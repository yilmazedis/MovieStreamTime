//
//  UIImageView+Ext.swift
//  MovieStreamTime
//
//  Created by yilmaz on 9.04.2023.
//

import UIKit

extension UIImageView {
    func networkImage(with downloader: ImageDownloader, url: URL) {
        downloader.downloadPhoto(with: url, completion: { (image, isCached) in
            if isCached {
                FastLogger.log(what: K.DebugMessage.fromCache, about: .info)
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                FastLogger.log(what: K.DebugMessage.fromURL, about: .info)
                UIView.transition(with: self, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }, completion: nil)
            }
        })
    }
}
