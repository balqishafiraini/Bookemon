//
//  SearchBarView.swift
//  Bookemon
//
//  Created by Balqis on 26/03/24.
//

import Foundation
import UIKit

protocol SearchBarDelegate: AnyObject {
    func didChangeSearchQuery(_ query: String)
    func didTapSearchButton()
}

class SearchBarView: UIView, UISearchBarDelegate {
    
    weak var delegate: SearchBarDelegate?
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SEARCH", for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(searchBar)
        addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchButton.topAnchor.constraint(equalTo: topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 80),
            searchButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didChangeSearchQuery(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    @objc func searchButtonTapped() {
        delegate?.didTapSearchButton()
    }
}
