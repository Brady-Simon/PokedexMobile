//
//  PokedexStorage.swift
//  Pokedex
//
//  Created by Brady Simon on 10/28/20.
//

import UIKit

/// The storage for all Pokemon to be held, as well as the next data sources to load.
class PokedexStorage {
    
    var pokemonList: [Pokemon]
    var fetchInterval: Int
    var pokeResource: PokemonResource?
    
    init(pokemonList: [Pokemon] = [], fetchInterval: Int = 10) {
        self.pokemonList = pokemonList
        self.fetchInterval = fetchInterval
        self.pokeResource = PokemonResource()
    }
    
}

extension PokedexStorage {
    /// Attempts to load more pokemon from PokeAPI.
    /// - Parameter completion: Returns the new pokemon that were fetched from the list.
    func loadMorePokemon(completion: @escaping ([Pokemon]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let resource = self.pokeResource,
               let nextResource = resource.fetchNext() {
                
                var newPokemon: [Pokemon] = []
                self.pokeResource = nextResource
                // Parse the resource results
                for pokeUrl in nextResource.results {
                    if let url = URL(string: pokeUrl.url) {
                        let result = NetworkManager.load(url: url, type: Pokemon.self)
                        switch result {
                        // Add the pokemon to PokedexStorage and the new list of pokmeon
                        case .success(let pokemon):
                            self.pokemonList.append(pokemon)
                            newPokemon.append(pokemon)
                            break
                        // Print out an error message and continue.
                        case .failure(let error):
                            print(error.localizedDescription)
                            print("Failed to load \(pokeUrl.name)")
                            break
                        }
                    }
                }
                
                completion(newPokemon)
            } else {
                completion([])
            }
        }
    }
}
