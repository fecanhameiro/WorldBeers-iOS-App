//
//  BeerService.swift
//  WorldBeers App
//
//  Created by Felipe C Canhameiro on 18/02/23.
//

import Foundation

/// A service class for retrieving lists of beers.
class BeerService : ServiceBase{
    
    /// Retrieves a list of beers from the Punk API.
    ///
    /// - Parameters:
    ///   - page: The page of results to retrieve.
    ///   - perPage: The number of results per page.
    ///   - completion: A completion block to handle the result of the operation.
    ///
    /// - Returns: A `Result` object containing either an array of `Beer` objects or an `Error`.
    func getBeerList(page: Int, perPage: Int, completion: @escaping (Result<[Beer], Error>) -> Void) {
        let url = "beers?page=\(page)&per_page=\(perPage)"
        self.get(url: url) { result in
            switch result {
                case .success(let beers):
                    completion(.success(beers))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
}
