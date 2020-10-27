//
//  MasterViewController.swift
//  Pokedex
//
//  Created by Brady Simon on 10/27/20.
//

import UIKit

class MasterViewController: UITableViewController {
    
    weak var pokemonDelegate: PokemonSelectionDelegate?
    
    let pokemonList: [Pokemon] = [
        Pokemon(id: 1, name: "bulbasaur", base_experience: 100, height: 2, weight: 20),
        Pokemon(id: 2, name: "ivysaur", base_experience: 120, height: 3, weight: 40),
        Pokemon(id: 3, name: "venusaur", base_experience: 200, height: 6, weight: 120),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath)
        let pokemon = pokemonList[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row): \(pokemon.name)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = pokemonList[indexPath.row]
        pokemonDelegate?.updatePokemon(selectedPokemon)
        
        if let detail = pokemonDelegate as? DetailViewController {
            splitViewController?.showDetailViewController(detail, sender: nil)
        }
    }
    

}
