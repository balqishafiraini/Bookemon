//
//  ViewController.swift
//  Bookemon
//
//  Created by Balqis on 25/03/24.
//

import UIKit

class DashboardViewController: UIViewController {
    
    private var pokemons: [PokemonData] = [] {
            didSet {
                dashboardView.tableView.reloadData()
            }
        }
        
        private var filteredPokemons: [PokemonData] = [] {
            didSet {
                dashboardView.tableView.reloadData()
            }
        }
    
    private var currentPage = 1
    private let pokemonAPI = PokemonAPI()
    
    lazy var dashboardView = DashboardView()
    
    override func loadView() {
        view = dashboardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dashboardView.tableView.dataSource = self
        dashboardView.tableView.delegate = self
        dashboardView.searchBarView.delegate = self
        dashboardView.tableView.register(PokemonViewCell.self, forCellReuseIdentifier: PokemonViewCell.reuseIdentifier)
        view.hideKeyboardWhenTappedAround()
        initialFetch()
    }
    
    private func initialFetch() {
        fetchNumberData(currentPage)
    }
    
    private func fetchNumberData(_ page: Int) {
        pokemonAPI.fetchNumberData(page: page) { [weak self] pokemons, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error:", error.localizedDescription)
                return
            }
            
            if let pokemons = pokemons {
                DispatchQueue.main.async {
                    self.pokemons.append(contentsOf: pokemons)
                    self.filteredPokemons = self.pokemons
                    self.currentPage += 1
                }
            }
        }
    }
    
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonViewCell.reuseIdentifier, for: indexPath) as? PokemonViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: filteredPokemons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = filteredPokemons[indexPath.row]
        let detailsVC = PokemonDetailsViewController()
        detailsVC.pokemon = selectedPokemon
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(detailsVC, animated: true)
        } else {
            print("Error: navigationController is nil.")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pokemons.count - 1 {
            fetchNumberData(currentPage)
        }
    }
}

extension DashboardViewController: SearchBarDelegate {
    func didChangeSearchQuery(_ query: String) {
        if query.isEmpty {
            filteredPokemons = pokemons
        } else {
            filteredPokemons = pokemons.filter { pokemon in
                return pokemon.name.lowercased().contains(query.lowercased()) ||
                    (pokemon.evolvesFrom ?? "").lowercased().contains(query.lowercased()) ||
                    pokemon.types.contains { $0.lowercased().contains(query.lowercased()) }
            }
        }
    }
}
