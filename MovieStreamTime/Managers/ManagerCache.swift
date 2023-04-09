//
//  ManagerCache.swift
//  MovieStreamTime
//
//  Created by yilmaz on 8.04.2023.
//

import Foundation

final class ManagerCache {
    static let cache: URLCache = {
        let diskPath = K.Cache.name

        if #available(iOS 13.0, *) {
            let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let cacheURL = cachesDirectory.appendingPathComponent(diskPath, isDirectory: true)
            return URLCache(
                memoryCapacity: ManagerCache.memoryCapacity,
                diskCapacity: ManagerCache.diskCapacity,
                directory: cacheURL
            )
        } else {
            return URLCache(
                memoryCapacity: ManagerCache.memoryCapacity,
                diskCapacity: ManagerCache.diskCapacity,
                diskPath: diskPath
            )
        }
    }()
    
    static func storeImageData(data: Data, response: URLResponse, for url: URL) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
    }

    static func imageData(for url: URL) -> Data? {
        return cache.cachedResponse(for: URLRequest(url: url))?.data
    }

    static let memoryCapacity: Int = 200.megabytes
    static let diskCapacity: Int = 400.megabytes
}

private extension Int {
    var megabytes: Int { return self * 1024 * 1024 }
}
