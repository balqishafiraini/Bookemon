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
}

class SearchBarView: UIView, UISearchBarDelegate {
    
    weak var delegate: SearchBarDelegate?
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        return searchBar
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
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didChangeSearchQuery(searchText)
    }
}
