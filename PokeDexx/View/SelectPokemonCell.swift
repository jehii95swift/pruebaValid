//
//  SelectPokemonCell.swift
//  PokeDexx
//
//  Created by Jenifer on 11/18/19.
//  Copyright © 2019 Jenifer. All rights reserved.
//

import UIKit

protocol PokemonCellDelegate: class {
    func requestPokeImage(for pokemon: String, completion: @escaping (String) -> ())
}

final class SelectPokemonCell: UICollectionViewCell {

    @IBOutlet private weak var imagePokemonCell: UIImageView!
    @IBOutlet private weak var pokemonLblCell: UILabel!
    weak var delegate: PokemonCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagePokemonCell.image = nil
    }
    
    func configName(pokemon : Pokemon) {
        let namePokemon = pokemon.name
        pokemonLblCell.text = namePokemon
        configureImage(with: pokemon.name)
    }
    
    private func configureImage(with name: String) {
        delegate?.requestPokeImage(for: name) { image in
            guard let url = URL(string: image) else { return }
            let data = try? Data(contentsOf: url)
            
            if let data = data {
                let image = UIImage(data: data)
                self.imagePokemonCell.image = image
            }
        }
    }
}

