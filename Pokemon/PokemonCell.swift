//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Gustavo Angulo on 10/06/25.
//

import UIKit

class PokemonCell: UITableViewCell{
    static let identifier = "PokemonCell"
    
    let nameLabel = UILabel()
    let iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(width pokemon: Pokemon) {
        nameLabel.text = pokemon.name.capitalized
        
        if let url = pokemon.imageUrl {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data {
                        DispatchQueue.main.async {
                        self.iconImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}
