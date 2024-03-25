//
//  PokemonViewCell.swift
//  Bookemon
//
//  Created by Balqis on 25/03/24.
//

import UIKit

class PokemonViewCell: UITableViewCell {
    
    static let reuseIdentifier = "PokemonCell"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var  typesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var evolvesFromLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pokemonImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        addSubview(nameLabel)
        addSubview(typesLabel)
        addSubview(evolvesFromLabel)
        addSubview(pokemonImageView)
        
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            pokemonImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            nameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 4),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            typesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            typesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            evolvesFromLabel.topAnchor.constraint(equalTo: typesLabel.bottomAnchor, constant: 4),
            evolvesFromLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            evolvesFromLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with pokemon: PokemonData) {
        nameLabel.text = "\(pokemon.name)"
        typesLabel.text = "Types: \(pokemon.types.joined(separator: ", "))"
        evolvesFromLabel.text = "Evolves from: \(pokemon.evolvesFrom ?? "Unknown")"
        if let imageUrl = URL(string: pokemon.images.small) {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
                guard let data = data, error == nil else {
                    print("Failed to load image:", error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                DispatchQueue.main.async {
                    self?.pokemonImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
