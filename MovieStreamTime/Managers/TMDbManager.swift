//
//  TMDbManager.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import Foundation

class TMDbManager {
    
    static let shared = TMDbManager()
    
    func fetch<T: Decodable>(with urlStr: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            Logger.log(what: K.ErrorMessage.url, about: .error)
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

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(ManagerFail.decode))
            }
        }
        task.resume()
    }
}
