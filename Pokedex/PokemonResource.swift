//
//  PokemonResource.swift
//  Pokedex
//
//  Created by Brady Simon on 10/28/20.
//

import Foundation

struct PokemonResource: Codable {
    var count: Int = 0
    var next: String = "https://pokeapi.co/api/v2/pokemon?limit=10&offset=0"
    var results: [PokeUrl] = []
    
    /// Fetches the next Pokemon Resource to load into the Pokedex.
    func fetchNext() -> PokemonResource? {
        if let url = nextUrl {
            let result = NetworkManager.load(url: url, type: PokemonResource.self)
            switch result {
            case .success(let resource):
                return resource
            default:
                return nil
            }
        } else {
            return nil
        }
    }
    
}

extension PokemonResource {
    var nextUrl: URL? {
        return URL(string: next)
    }
}
