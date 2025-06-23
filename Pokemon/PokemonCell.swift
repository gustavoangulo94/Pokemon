//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Gustavo Angulo on 10/06/25.
//

import UIKit

class PokemonCell: UITableViewCell{
    static let identifier = "PokemonCell"
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, nameLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.textAlignment = .center
//        nameLabel.layer.borderWidth = 1
        nameLabel.backgroundColor = . gray
        nameLabel.layer.opacity = 0.6
        nameLabel.textColor = .black
        
        return nameLabel
    }()
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
//        iconImageView.layer.borderWidth = 1
        iconImageView.contentMode = .scaleToFill
        
        return iconImageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        setHierarchy()
    }
    
    func setHierarchy(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconImageView)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            iconImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 180),
            iconImageView.widthAnchor.constraint(equalToConstant: 350),
//            nameLabel.widthAnchor.constraint(equalToConstant: 400),
            
        ])
    }
    
    func configure(width pokemon: Pokemon) {
        nameLabel.text = pokemon.name.capitalized
//        iconImageView.alpha = 0.3
    
        if let url = pokemon.imageUrl {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data {
                        DispatchQueue.main.async {
                        self.iconImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        setConstraints()
    }
}
