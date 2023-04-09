//
//  TMDbManager.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import Foundation

final class TMDbManager {
    
    static let shared = TMDbManager()
    private let cache = ManagerCache.cache
    
    func fetch<T: Decodable>(with url: URL?, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = url else {
            FastLogger.log(what: K.ErrorMessage.url, about: .error)
            return
        }
        
        if let data = ManagerCache.imageData(for: url) {
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(ManagerFail.decode))
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data else {
                completion(.failure(ManagerFail.data))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ManagerFail.response))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(ManagerFail.statusCode))
                return
            }
            
            guard error == nil else {
                completion(.failure(ManagerFail.error))
                return
            }
            
            FastLogger.log(what: K.InfoMessage.api, about: .info)
            
            ManagerCache.storeImageData(data: data, response: httpResponse, for: url)

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(ManagerFail.decode))
            }
        }
        task.resume()
    }
}
