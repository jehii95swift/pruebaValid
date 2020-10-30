//
//  Services.swift
//  PokeDexx
//
//  Created by Jenifer on 11/18/19.
//  Copyright © 2019 Jenifer. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class Services {
    
    func requestPokemons(completion: @escaping ([Pokemon]) -> ()) {
        
        var pokemons: [Pokemon] = []
        Alamofire.request("https://pokeapi.co/api/v2/pokemon").responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                print("JSON: \(json)")
                
                if let pokemones = json["results"] as? [[String: String]] {
                    for pokemonDict in pokemones {
                        let name = pokemonDict["name"] ?? ""
                        let url = pokemonDict["url"] ?? ""
                        let pokemon = Pokemon(name:name, url:url)
                        pokemons.append(pokemon)
                    }
                    
                    completion(pokemons)
                }
            }
        }
    }
    
    func requestInfo(name: String, completion: @escaping (Pokemon) -> ()) {
        
        Alamofire.request("https://pokeapi.co/api/v2/pokemon/\(name)").responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                print("JSON: \(json)")
                
                guard let pokemon = ObjectMapper.Mapper<Pokemon>().map(JSON: json) else {
                    return
                }
                completion(pokemon)
            }
        }
    }
    
    func requestPokeImage(for pokemon: String, completion: @escaping (String) -> ()) {
        Alamofire.request("https://pokeapi.co/api/v2/pokemon/\(pokemon)").responseJSON { response in
            
            if let json = response.result.value as? [String: Any],
               let sprites = json["sprites"] as? [String: Any],
               let defaultSprite = sprites["front_default"] as? String {
                completion(defaultSprite)
            }
        }
    }
}
