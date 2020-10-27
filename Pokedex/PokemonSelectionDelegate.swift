//
//  PokemonSelectionDelegate.swift
//  Pokedex
//
//  Created by Brady Simon on 10/27/20.
//

import Foundation

/// Allows controllers to update their delegates with a new pokemon.
protocol PokemonSelectionDelegate: AnyObject {
    func updatePokemon(_ newPokemon: Pokemon)
}
