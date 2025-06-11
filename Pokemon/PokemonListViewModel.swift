//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Gustavo Angulo on 10/06/25.
//

class PokemonListViewModel {
    private let service = Service()
    var pokemons : [Pokemon] = []
    
    func load(completion: @escaping () -> Void){
        service.fetchPokemons { [weak self] result in
            self?.pokemons = result
            completion()
        }
    }
}
