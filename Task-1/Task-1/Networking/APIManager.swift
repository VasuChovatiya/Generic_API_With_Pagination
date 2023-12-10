//
//  APIManager.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//


import Foundation

typealias Handler<T> = (Result<T, DataError>) -> Void

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}


class APIManager {
    
    //MARK: - Shared Instances
    
    
    static let shared = APIManager()
    
    //MARK: - Functionss
    
    
    // Using async await
    func request<T: Decodable>(url: String) async throws ->  T {
        guard let url = URL(string: url) else {
            throw DataError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw DataError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
    
    
    // Using Completion handler
    func fetchNews<T: Decodable>(
            urlString: String = userURL,
            modelType: T.Type,
            completionHandler: @escaping Handler<T>
        ) {
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(.invalidURL))
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data, error == nil else {
                    completionHandler(.failure(.invalidData))
                    return
                }

                guard let response = response as? HTTPURLResponse,
                      200 ... 299 ~= response.statusCode else {
                    completionHandler(.failure(.invalidResponse))
                    return
                }

                do {
                    let newsResponse = try JSONDecoder().decode(modelType, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(newsResponse))
                    }
                }catch {
                    print("news fetch api error", error)
                    completionHandler(.failure(.network(error)))
                }
            }.resume()
        }

}

