//
//  ViewController.swift
//  PokeDexx
//
//  Created by Jenifer on 11/18/19.
//  Copyright © 2019 Jenifer. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private let controller = Controller()
    private var pokemons: [Pokemon] = []
    private var filteredPokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        requestPokemons()
        registerCell()
        configGradient()
        searchTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let searchedText = textField.text else {
            return
        }
        
        filteredPokemons = pokemons.filter { $0.name.starts(with: searchedText) }
        collectionView.reloadData()
    }
    
    private func requestPokemons() {
        controller.requestPokemons() { [weak self] pokemons  in
            self?.pokemons = pokemons
            self?.filteredPokemons = pokemons
            self?.collectionView.reloadData()
        }
    }
}

private extension ViewController {
    
    func configGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    func registerCell () {
        collectionView.register(UINib(nibName: "SelectPokemonCell", bundle: nil), forCellWithReuseIdentifier: "SelectPokemonCell")
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectPokemonCell" , for: indexPath) as? SelectPokemonCell
            else { return UICollectionViewCell() }
        let namePokemon = filteredPokemons[indexPath.row]
        cell.delegate = self
        cell.configName(pokemon: namePokemon)
        
        return cell
    }
}

//NOTA: Por cada pokemon se consulta su informacion en este método, lo cual no es eficiente, lo que se deberia hacer es descargar toda la informacion de los pokemones desde el principio y aca solamente consultar localmente cada uno, para no tener que hacer un request por cada celda.
//Pero Dadas las limitaciones del API y del tiempo, lo dejo asi, pero no es como deberia ser.
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let vc = DetailPokemon()
        let pokemon = filteredPokemons[indexPath.row]
        vc.loadViewIfNeeded()
        vc.configurePokemon(pokemon: pokemon)
        vc.requestInfo(name: pokemon.name)
        self.navigationController!.pushViewController(vc, animated: true)
    }
}

extension ViewController: PokemonCellDelegate {
    func requestPokeImage(for pokemon: String, completion: @escaping (String) -> ()) {
        return controller.requestPokeImage(for: pokemon, completion: completion)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt  indexpath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 60)
    }
}

