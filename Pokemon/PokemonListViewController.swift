//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by Gustavo Angulo on 10/06/25.
//

import UIKit

class PokemonListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView = UITableView()
    let viewModel = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokémons"
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        viewModel.load {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else {
            return UITableViewCell()
        }
        cell.configure(width: viewModel.pokemons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = viewModel.pokemons[indexPath.row]
        fetchPokemonDetail(named: selectedPokemon.name) { detail in
            guard let detail = detail else { return }
            DispatchQueue.main.async {
                let detailVC = PokemonDetailViewController()
                detailVC.pokemonDetail = detail
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    func fetchPokemonDetail(named name: String, completion: @escaping (PokemonDetail?) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                completion(detail)
            } catch {
                print("Erro ao decodificar JSON:", error)
                completion(nil)
            }
        }.resume()
    }
}
