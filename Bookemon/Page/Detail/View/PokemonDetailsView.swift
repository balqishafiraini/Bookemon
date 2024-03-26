//
//  PokemonDetailsView.swift
//  Bookemon
//
//  Created by Balqis on 26/03/24.
//

import Foundation
import UIKit

class PokemonDetailsView: UIView {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  typesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var evolvesFromLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageContainerView)
        imageContainerView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(typesLabel)
        contentView.addSubview(evolvesFromLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageContainerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.65),
            
            imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            typesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            typesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            evolvesFromLabel.topAnchor.constraint(equalTo: typesLabel.bottomAnchor, constant: 4),
            evolvesFromLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func configure(with pokemon: PokemonData) {
        nameLabel.text = pokemon.name
        typesLabel.text = "Types: \(pokemon.types.joined(separator: ", "))"
        evolvesFromLabel.text = "Evolves from: \(pokemon.evolvesFrom ?? "Unknown")"
        if let imageUrl = URL(string: pokemon.images.large) {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
