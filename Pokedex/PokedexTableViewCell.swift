//
//  PokedexTableViewCell.swift
//  Pokedex
//
//  Created by Brady Simon on 10/28/20.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
