//
//  ImageDownloader.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import UIKit

final class ImageDownloader {

    private var imageDataTask: URLSessionDataTask?
    private let cache = ManagerCache.cache

    func downloadPhoto(with url: URL, completion: @escaping ((UIImage?, Bool) -> Void)) {

        if let data = ManagerCache.imageData(for: url),
            let image = UIImage(data: data) {
            completion(image, true)
            return
        }

        imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            self?.imageDataTask = nil

            guard let data = data,
                  let response = response,
                  let image = UIImage(data: data),
                  error == nil
            else { return }

            ManagerCache.storeImageData(data: data, response: response, for: url)

            DispatchQueue.main.async {
                let decodedImage = image.preloadedImage()
                completion(decodedImage, false)
            }
        }
        imageDataTask?.resume()
    }

    func cancel() {
        imageDataTask?.cancel()
    }

}
