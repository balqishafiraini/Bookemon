//
//  PokemonDetailsViewController.swift
//  Bookemon
//
//  Created by Balqis on 26/03/24.
//

import Foundation
import UIKit

class PokemonDetailsViewController: UIViewController {
    var pokemon: PokemonData?
    
    private lazy var pokemonDetailsView: PokemonDetailsView = {
        let view = PokemonDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pokemonDetailsView)
        NSLayoutConstraint.activate([
            pokemonDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if let pokemon = pokemon {
            pokemonDetailsView.configure(with: pokemon)
        }
    }
}
