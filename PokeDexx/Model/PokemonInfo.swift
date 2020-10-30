//
//  PokemonInfo.swift
//  PokeDexx
//
//  Created by Jenifer on 11/19/19.
//  Copyright © 2019 Jenifer. All rights reserved.
//

import Foundation
import ObjectMapper

class PokemonInfo {
    
    var speed:Int = 0
    var specialDefense: Int = 0
    var specialAttack: Int = 0
    var defense: Int = 0
    var attack: Int = 0
    var hp:Int = 0
    
    init() {
        
    }
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        speed <- map["speed"]
        specialDefense <- map["special-defense"]
        specialAttack <- map["special-attack"]
        defense <- map["defense"]
        attack <- map["attack"]
        hp <- map["map"]
    }
}

