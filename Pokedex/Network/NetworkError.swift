//
//  NetworkError.swift
//  Pokedex
//
//  Created by Brady Simon on 10/27/20.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case unavailable
    case decodingFailure
    case other(message: String)
}
