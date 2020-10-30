//
//  PokemonStats.swift
//  PokeDexx
//
//  Created by Jenifer on 11/19/19.
//  Copyright © 2019 Jenifer. All rights reserved.
//

import Foundation
import ObjectMapper

class PokemonStats: Mappable {
    
    var baseStat: Int = 0
    var statName: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        baseStat <- map["base_stat"]
        let stat = map.JSON["stat"] as? [String: String]
        statName = stat?["name"] ?? ""
        
    }
}
