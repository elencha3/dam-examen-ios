//
//  ViewController.swift
//  Pokemon
//
//  Created by Miguel Estévez.
//  Copyright © 2020 Miguel Estévez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var pokemonList: PokemonList?
    var pokemons: [Pokemon?] = []
        var images: [UIImage?] = []
        let MAX_POKEMONS = 20
        var imagesDownload = 0
        var connection = Connection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.alpha = 0.0
//        downloadPokemonsInfo()
    }
    
    // MARK: - UITableView delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        cell.pokemonNameLabel.text = pokemonList?.results[indexPath.row].name.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetailSegue", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            if let detailVC = segue.destination as? DetailViewController, let indexPath = sender as? IndexPath {
                detailVC.pokemonUrl = pokemonList?.results[indexPath.row].url
                detailVC.pokemonName = pokemonList?.results[indexPath.row].name.capitalized
            }
        }
    }
//    func downloadPokemonsInfo() {
//            for i in 1...MAX_POKEMONS {
//                connection.getPokemon(withId: i) { (pokemon) in
//                    if let pokemon = pokemon, let id = pokemon.id {
//                        self.pokemons[id - 1] = pokemon
//                        if let image = pokemon.sprites?.front_default{
//                            self.connection.getSprite(with: image) { (image) in
//                                self.imagesDownload = self.imagesDownload + 1
//                                if let image = image {
//                                    self.images[id-1] = image
//                                }
//                                if self.imagesDownload == self.MAX_POKEMONS {
//                                    DispatchQueue.main.async {
//                                        self.tableView.reloadData()
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
}

