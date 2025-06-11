//
//  Pokemon.swift
//  Pokemon
//
//  Created by Gustavo Angulo on 10/06/25.
//

import Foundation

struct PokemonResponse: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String

    var id: Int? {
        if let urlComponents = URL(string: url)?.pathComponents,
           let idString = urlComponents.last(where: { Int($0) != nil }) {
            return Int(idString)
        }
        return nil
    }

    var imageUrl: URL? {
        guard let id = id else { return nil }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}
