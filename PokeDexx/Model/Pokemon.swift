//
//  Pokemon.swift
//  PokeDexx
//
//  Created by Jenifer on 11/18/19.
//  Copyright © 2019 Jenifer. All rights reserved.
//

import Foundation
import ObjectMapper

class Pokemon: Mappable {
    
    var name:String = ""
    var stats: [PokemonStats] = []
    var pokemonInfo: PokemonInfo = PokemonInfo()
    var sprites: [String:Any] = [:]
    var statsArray: [[String: Int]] {
        var stats: [[String: Int]] = []
        let speed: [String: Int] = ["Speed": pokemonInfo.speed]
        let specialDef: [String: Int] = ["Special Defense": pokemonInfo.specialDefense]
        let specialAttack: [String: Int] = ["Special Attack": pokemonInfo.specialAttack]
        let defense: [String: Int] = ["Defense": pokemonInfo.defense]
        let attack: [String: Int] = ["Attack": pokemonInfo.attack]
        let hp: [String: Int] = ["HP": pokemonInfo.hp]
        
        stats.append(speed)
        stats.append(specialDef)
        stats.append(specialAttack)
        stats.append(defense)
        stats.append(attack)
        stats.append(hp)
        return stats
    }
    
    init(name: String, url: String) {
        self.name = name
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        stats <- map["stats"]
        sprites <- map["sprites"]
        
        
        //estas funciones son ineficientes y podrian ser mejoradas con un metodo mejor para el mapeo de los stats del pokemon, pero por la premura del asunto, las dejo con esta logica
        if let speedStat = (stats.first { $0.statName == "speed" }) {
            pokemonInfo.speed = speedStat.baseStat
        }
        
        if let specialDefStat = (stats.first { $0.statName == "special-defense" }) {
            pokemonInfo.specialDefense = specialDefStat.baseStat
        }
        
        if let specialAttkStat = (stats.first { $0.statName == "special-attack" }) {
            pokemonInfo.specialAttack = specialAttkStat.baseStat
        }
        
        if let defense = (stats.first { $0.statName == "defense" }) {
            pokemonInfo.defense = defense.baseStat
        }
        
        if let attack = (stats.first { $0.statName == "attack" }) {
            pokemonInfo.attack = attack.baseStat
        }
        
        if let hp = (stats.first { $0.statName == "hp" }) {
            pokemonInfo.hp = hp.baseStat
        }
    }
}
