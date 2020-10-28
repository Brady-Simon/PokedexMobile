//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Brady Simon on 10/27/20.
//

import Foundation

struct NetworkManager {
    
    static func load<T: Decodable>(url: URL, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode(T.self, from: data) {
                completion(.success(decodedData))
                return
            } else {
                completion(.failure(.decodingFailure))
                return
            }
        } else {
            completion(.failure(.unavailable))
            return
        }
    }
    
    static func load<T: Decodable>(url: URL, type: T.Type) -> Result<T, NetworkError> {
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode(T.self, from: data) {
                return .success(decodedData)
            } else {
                return .failure(.decodingFailure)
            }
        } else {
            return .failure(.unavailable)
        }
    }
    
}
