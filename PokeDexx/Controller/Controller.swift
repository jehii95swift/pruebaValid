//
//  Controller.swift
//  PokeDexx
//
//  Created by Jenifer on 11/18/19.
//  Copyright © 2019 Jenifer. All rights reserved.
//

import Foundation

class Controller {
    
    var services = Services()
    
    func requestPokemons(completion: @escaping ([Pokemon]) -> ()) {
        services.requestPokemons(completion: completion)
    }
    
    func requestInfo(name: String, completion: @escaping (Pokemon) -> ()) {
        services.requestInfo(name: name, completion: completion)
    }
    
    func requestPokeImage(for pokemon: String, completion: @escaping (String) -> ()) {
        return services.requestPokeImage(for: pokemon, completion: completion)
    }
}
