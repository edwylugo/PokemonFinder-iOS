//
//  PokemonsTableViewCell.swift
//  PokemonFinder
//
//  Created by Edwy Lugo on 31/05/19.
//  Copyright © 2019 Edwy Lugo. All rights reserved.
//

import UIKit

class PokemonsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbNamePokemon: UILabel!
    @IBOutlet weak var ivPokemon: UIImageView!
    
    override func prepareForReuse() {
        
        lbNamePokemon.text = "Name Pokemon"
        ivPokemon.image = UIImage(named: "pikachu")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
