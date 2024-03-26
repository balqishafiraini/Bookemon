//
//  PokemonModel.swift
//  Bookemon
//
//  Created by Balqis on 26/03/24.
//

import Foundation

struct PokemonModel: Decodable {
    let data: [PokemonData]
}
    
struct PokemonData: Codable {
    let id: String
    let name: String
    let types: [String]
    let evolvesFrom: String?
    let images: Image
    let level: String
    let hp: String
}

struct Image: Codable {
    let small: String
    let large: String
}
