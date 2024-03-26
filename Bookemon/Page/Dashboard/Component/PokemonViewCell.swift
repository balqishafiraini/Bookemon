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
    
    lazy var imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(imageContainerView)
        imageContainerView.addSubview(pokemonImageView)
        addSubview(nameLabel)
        addSubview(typesLabel)
        addSubview(evolvesFromLabel)
        
        
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageContainerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.3),
            
            pokemonImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            pokemonImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            pokemonImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            pokemonImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),

            nameLabel.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            typesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            typesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            evolvesFromLabel.topAnchor.constraint(equalTo: typesLabel.bottomAnchor, constant: 4),
            evolvesFromLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
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
