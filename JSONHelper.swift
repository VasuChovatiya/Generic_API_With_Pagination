//
//  JSONHelper.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 17/02/25.
//

import Foundation

struct JSONHelper {
    static func decode<T: Codable>(_ type: T.Type, from data: Data) -> Result<T, Error> {
        let decoder = JSONDecoder()
        do {
            let decodedObject = try decoder.decode(T.self, from: data)
            return .success(decodedObject)
        } catch {
            return .failure(error)
        }
    }
    
    static func decodeArray<T: Codable>(_ type: [T].Type, from data: Data) -> Result<[T], Error> {
        let decoder = JSONDecoder()
        do {
            let decodedArray = try decoder.decode([T].self, from: data)
            return .success(decodedArray)
        } catch {
            return .failure(error)
        }
    }
    
    static func encode<T: Codable>(_ object: T) -> Result<Data, Error> {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(object)
            return .success(jsonData)
        } catch {
            return .failure(error)
        }
    }
    
    static func encodeArray<T: Codable>(_ objects: [T]) -> Result<Data, Error> {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(objects)
            return .success(jsonData)
        } catch {
            return .failure(error)
        }
    }
    
    static func jsonToDictionary(_ data: Data) -> Result<[String: Any], Error> {
        do {
            if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return .success(jsonDict)
            } else {
                return .failure(NSError(domain: "Invalid JSON", code: -1, userInfo: nil))
            }
        } catch {
            return .failure(error)
        }
    }
    
    static func dictionaryToJson(_ dictionary: [String: Any]) -> Result<Data, Error> {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            return .success(jsonData)
        } catch {
            return .failure(error)
        }
    }
}


struct User: Codable {
    let id: Int
    let name: String
}

// MARK: - Enco

fileprivate func encodingExample() {
    let user = User(id: 1, name: "John Doe")
    switch JSONHelper.encode(user) {
    case .success(let jsonData):
        print("JSON Data:", String(data: jsonData, encoding: .utf8)!)
    case .failure(let error):
        print("Encoding failed:", error)
    }
}


fileprivate func decodingExample() {
    let jsonString = "{\"id\":1,\"name\":\"John Doe\"}"
    if let jsonData = jsonString.data(using: .utf8) {
        switch JSONHelper.decode(User.self, from: jsonData) {
        case .success(let user):
            print("Decoded User:", user)
        case .failure(let error):
            print("Decoding failed:", error)
        }
    }
}


fileprivate func encodingArrayOfObjectsExample() {
    let users = [User(id: 1, name: "John Doe"), User(id: 2, name: "Jane Doe")]
    switch JSONHelper.encodeArray(users) {
    case .success(let jsonData):
        print("JSON Array Data:", String(data: jsonData, encoding: .utf8)!)
    case .failure(let error):
        print("Encoding array failed:", error)
    }
}

fileprivate func decodingArrayOfObjectsExample() {
    let jsonArrayString = "[{\"id\":1,\"name\":\"John Doe\"},{\"id\":2,\"name\":\"Jane Doe\"}]"
    if let jsonData = jsonArrayString.data(using: .utf8) {
        switch JSONHelper.decodeArray([User].self, from: jsonData) {
        case .success(let users):
            print("Decoded Users:", users)
        case .failure(let error):
            print("Decoding array failed:", error)
        }
    }
}


class APIManager2 {
    static let shared = APIManager2()
    private init() {}
    
    enum HTTPMethod: String {
        case GET, POST, PUT, DELETE
    }
    
    func request<T: Codable>(url: URL, method: HTTPMethod, body: Data? = nil) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
