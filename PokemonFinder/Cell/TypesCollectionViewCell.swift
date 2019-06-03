//
//  TypesCollectionViewCell.swift
//  PokemonFinder
//
//  Created by Edwy Lugo on 31/05/19.
//  Copyright © 2019 Edwy Lugo. All rights reserved.
//

import UIKit

class TypesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var ivType: UIImageView!
    @IBOutlet weak var lbTitleType: UILabel!
    
    
    
    override func prepareForReuse() {
        
        lbTitleType.text = "Title"
        ivType.image = UIImage(named: "pokemon-logo")
//
        
    }
    
}
