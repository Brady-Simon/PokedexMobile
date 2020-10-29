//
//  MasterViewController.swift
//  Pokedex
//
//  Created by Brady Simon on 10/27/20.
//

import UIKit

class MasterViewController: UITableViewController {
    
    weak var pokemonDelegate: PokemonSelectionDelegate?
    private var pokedexStorage: PokedexStorage = PokedexStorage()
    private lazy var dataSource = getDataSource()
    
    let pokemonList: [Pokemon] = [
        Pokemon(id: 1, name: "bulbasaur", base_experience: 100, height: 2, weight: 20),
        Pokemon(id: 2, name: "ivysaur", base_experience: 120, height: 3, weight: 40),
        Pokemon(id: 3, name: "venusaur", base_experience: 200, height: 6, weight: 120),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        updatePokedex()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updatePokedex))
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .systemRed
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections(in: tableView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedexStorage.pokemonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == pokedexStorage.pokemonList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath)
            cell.textLabel?.text = "Fetch more Pokemon"
            return cell
        } else {
            return dataSource.tableView(tableView, cellForRowAt: indexPath)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedPokemon = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        pokemonDelegate?.updatePokemon(selectedPokemon)
        
        if let detail = pokemonDelegate as? DetailViewController {
            splitViewController?.showDetailViewController(detail, sender: nil)
        }
    }
    

}

private extension MasterViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Pokemon>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>
    
    func getDataSource() -> DataSource {
        let dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, pokemon) -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath)
                cell.textLabel?.text = "\(indexPath.row + 1): \(pokemon.name)"
                return cell
            }
        )
        return dataSource
    }
    
    func applySnapshot(newPokemon: [Pokemon], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(pokedexStorage.pokemonList)
        dataSource.apply(snapshot)
    }
    
}

// MARK: - Fetch Data Properties; refactor later.
private extension MasterViewController {
    @objc func updatePokedex() {
        pokedexStorage.loadMorePokemon() { newPokemon in
            DispatchQueue.main.async { [weak self] in
                self?.applySnapshot(newPokemon: newPokemon)
            }
        }
    }
}
