//
//  PokemonAPI.swift
//  Bookemon
//
//  Created by Balqis on 25/03/24.
//

import Foundation

class PokemonAPI {
    
    private var tasks: [URLSessionDataTask] = []
    
    func fetchPokemonData(page: Int, completion: @escaping ([PokemonData]?, Error?) -> Void) {
        guard NetworkManager.shared.isConnectedToNetwork() else {
            completion(nil, NSError(domain: "PokemonAPI", code: 0, userInfo: [NSLocalizedDescriptionKey: "No internet connection."]))
            return
        }
        
        let endpoint = "https://api.pokemontcg.io/v2/cards?page=\(page)&pageSize=8"
        guard let url = URL(string: endpoint) else {
            completion(nil, NSError(domain: "PokemonAPI", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        guard !tasks.contains(where: { $0.originalRequest?.url == url }) else {
            completion(nil, NSError(domain: "PokemonAPI", code: 0, userInfo: [NSLocalizedDescriptionKey: "Task already exists for this URL."]))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "PokemonAPI", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received."]))
                return
            }
            
            do {
                let pokemonData = try JSONDecoder().decode(PokemonModel.self, from: data)
                let uniquePokemons = pokemonData.data
                completion(uniquePokemons, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
        tasks.append(task)
    }
}
