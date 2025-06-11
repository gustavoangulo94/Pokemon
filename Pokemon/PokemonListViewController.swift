//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by Gustavo Angulo on 10/06/25.
//

import UIKit

class PokemonListViewController: UIViewController, UITableViewDataSource {
    let tableView = UITableView()
    let viewModel = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokémons"
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.identifier)
        tableView.dataSource = self

        viewModel.load {
            self.tableView.reloadData()
        }
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
}
