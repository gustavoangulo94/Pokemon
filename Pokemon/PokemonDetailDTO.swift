//
//  PokemonDetailDTO.swift
//  Pokemon
//
//  Created by Gustavo Angulo on 23/06/25.
//

import Foundation


struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [PokemonType]
}

struct Sprites: Codable {
    let frontDefault: URL?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonType: Codable {
    let slot: Int
    let type: Species
}

struct Species: Codable {
    let name: String
}
