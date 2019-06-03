//
//  APIManager.swift
//  PokemonFinder
//
//  Created by Edwy Lugo on 30/05/19.
//  Copyright © 2019 Edwy Lugo. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    
    static let shared = APIManager()
    
    let pokemons: [Pokemons]
    let types: [Types]
    
    init() {
        
        let pokemonsURL = Bundle.main.url(forResource: "pokemons", withExtension: "json")!
        let typesURL = Bundle.main.url(forResource: "types", withExtension: "json")!
        
        do {
            
            let decoder = JSONDecoder()
            
            let pokemonsData = try Data(contentsOf: pokemonsURL)
            pokemons = try decoder.decode([Pokemons].self, from: pokemonsData)
            
            let typesData = try! Data(contentsOf: typesURL)
            types = try! decoder.decode([Types].self, from: typesData)
            
            print(pokemons[0].name)
            print(pokemons.count)
            print(types.count)

        } catch let parsingError {
            print("Error", parsingError)
            pokemons = []
            types = []
        }
        
    }
}
