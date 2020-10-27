//
//  Pokemon.swift
//  Pokedex
//
//  Created by Brady Simon on 10/27/20.
//

import Foundation

struct Pokemon: Codable {
    
    var id: Int
    var name: String
    var base_experience: Int
    var height: Int
    var weight: Int
    
}

extension Pokemon {
    /// The URL string of the
    var imageLocation: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
    
    /// The URL of the pokemon's image.
    var imageUrl: URL? {
        return URL(string: imageLocation)
    }
}
