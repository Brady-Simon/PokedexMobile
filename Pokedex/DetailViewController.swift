//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Brady Simon on 10/27/20.
//

import UIKit

class DetailViewController: UIViewController, PokemonSelectionDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Updates the UI when the pokemon is changed.
    private func updateUI() {
        loadViewIfNeeded()
        // Load image here
        if let pokemon = pokemon {
            title = pokemon.name
            name.text = pokemon.name
            height.text = "Height: \(pokemon.height)"
            weight.text = "Weight: \(pokemon.weight)"
            
            DispatchQueue.main.async {
                if let url = pokemon.imageUrl, let data = try? Data(contentsOf: url) {
                    self.imageView.image = UIImage(data: data)
                }
            }
            
        }
    }
    
    func updatePokemon(_ newPokemon: Pokemon) {
        pokemon = newPokemon
    }

}
