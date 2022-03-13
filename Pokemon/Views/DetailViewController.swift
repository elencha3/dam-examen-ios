//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Miguel Estévez on 12/03/2020.
//  Copyright © 2020 Miguel Estévez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pokemonUrl: String?
    var pokemonName: String?
    
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet var battleSwitch: UISwitch!
    @IBOutlet var defaultSwitch: UISwitch!
    @IBOutlet var megaSwitch: UISwitch!
    @IBOutlet weak var ampliarImagen: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pokemon"
        pokemonNameLabel.text = pokemonName
       
        getPokemon()
    }
    
    func getPokemon() {
        guard let urlString = pokemonUrl else { return }
        
        Connection().getPokemon(fromUrl: urlString) {
               pokemon in
               
               if let pokemon = pokemon {
                   Connection().getSprite(with: pokemon.sprites?.front_default ?? "") {
                       image in
                       DispatchQueue.main.async {
                        self.pokemonImageView.image = image
                        self.battleSwitch.isOn = pokemon.battleOnly ?? false
                        if(self.battleSwitch.isOn) {
                            self.view.backgroundColor = .lightGray
                        } else {
                            self.view.backgroundColor = .white
                        }

                        self.defaultSwitch.isOn = pokemon.isDefault ?? false
                        self.megaSwitch.isOn = pokemon.isMega ?? false 
                       }
                   }
               }
               else {
                   // Notify user an error occured
               }
           }
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBigImage" {
            if let imageVC = segue.destination as? ImageViewController, let indexPath = sender as? IndexPath {
                if let url = sender as? String {
                    imageVC.pokemonUrl = pokemonUrl
                }
                
                
            }
        }
    }
}
