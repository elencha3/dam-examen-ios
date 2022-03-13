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
    
    var connection = Connection()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title="List"
        
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        downloadPokemonsInfo()
    }
    
    // MARK: - UITableView delegate
     func numberOfSections(in tableView: UITableView) -> Int {
          
           return 1
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        
        if let pokemonList = pokemonList {
            cell.pokemonNameLabel.text = pokemonList.results[indexPath.row].name.capitalized
        }
      
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
    
    
    func downloadPokemonsInfo() {
        
        connection.getPokemonList { pokemonList in
            if let pokemonsList = pokemonList {
                self.pokemonList = pokemonsList
                self.activityIndicator.isHidden = true
            }
        }
        
    }
    
}

