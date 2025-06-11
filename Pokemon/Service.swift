//
//  Untitled.swift
//  Pokemon
//
//  Created by Gustavo Angulo on 10/06/25.
//

import Foundation

class Service {
    private let baseURL: String = ""
    
    func fetchPokemons(completion: @escaping ([Pokemon]) -> Void){
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let decode = try JSONDecoder().decode(PokemonResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decode.results)
                }
            }catch {
                print("Erro ai decodificar: \(error)")
            }
        }.resume()
    }
}
