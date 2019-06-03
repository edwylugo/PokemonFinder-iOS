//
//  Pokemons.swift
//  PokemonFinder
//
//  Created by Edwy Lugo on 30/05/19.
//  Copyright © 2019 Edwy Lugo. All rights reserved.
//

import Foundation
import UIKit


class Pokemons: Codable {
    let name: String
    let thumbnailImage: String
    let type: [String]
    
    init(name: String, thumbnailImage: String, type: [String]) {
        self.thumbnailImage = thumbnailImage
        self.name = name
        self.type = type
    }

}
