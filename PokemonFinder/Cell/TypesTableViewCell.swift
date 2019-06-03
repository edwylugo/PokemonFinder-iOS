//
//  TypesTableViewCell.swift
//  PokemonFinder
//
//  Created by Edwy Lugo on 30/05/19.
//  Copyright © 2019 Edwy Lugo. All rights reserved.
//

import UIKit

class TypesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var iconType: UIImageView!
    @IBOutlet weak var titleType: UILabel!
    @IBOutlet weak var radioCheckMark: UIImageView!
    

    
    
    override func prepareForReuse() {
        titleType.text = "Type Pokemon"
        iconType.image = UIImage(named: "pokemon-logo")
        radioCheckMark.image = UIImage(named: "radio-off")
        
    }
    
}
