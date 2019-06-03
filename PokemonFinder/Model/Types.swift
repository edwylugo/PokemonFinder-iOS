//
//  Types.swift
//  PokemonFinder
//
//  Created by Edwy Lugo on 30/05/19.
//  Copyright © 2019 Edwy Lugo. All rights reserved.
//

import Foundation
import UIKit


class Types: Codable {
    let results: [Type]

    init(results: [Type]) {
        self.results = results
    }
}


class Type: Codable {
    let thumbnailImage: String
    let name: String
    
    init(thumbnailImage: String, name: String) {
        self.thumbnailImage = thumbnailImage
        self.name = name
    }
}







