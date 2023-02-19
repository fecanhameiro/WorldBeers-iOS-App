//
//  ServiceBase.swift
//  WorldBeers App
//
//  Created by Felipe C Canhameiro on 18/02/23.
//

import Foundation

/// A base service class for making HTTP requests.
class ServiceBase {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Makes an HTTP GET request to the specified URL and decodes the response into an array of `Beer` objects.
    ///
    /// - Parameters:
    ///   - url: The URL to request.
    ///   - completion: A completion block to handle the result of the operation.
    ///
    /// - Returns: A `Result` object containing either an array of `Beer` objects or an `Error`.
    func get(url: String, completion: @escaping (Result<[Beer], Error>) -> Void) {
        
        let url = URL(string: "\(Constants.apiUrl)/\(url)")!
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "ServiceErrorDomain", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Unexpected server response"])
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "ServiceErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .custom { keys in
                    var lastKey = keys.last!.stringValue
                    lastKey = lastKey.prefix(1).lowercased() + lastKey.dropFirst()
                    return AnyCodingKey(stringValue: lastKey)!
                }
                let beers = try decoder.decode([Beer].self, from: data)
                completion(.success(beers))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    /// A custom `CodingKey` implementation that converts the last key in a key path to lowerCamelCase.
    private struct AnyCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int? { return nil }
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
}
