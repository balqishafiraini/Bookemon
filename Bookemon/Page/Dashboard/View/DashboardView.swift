//
//  DashboardView.swift
//  Bookemon
//
//  Created by Balqis on 25/03/24.
//

import UIKit

class DashboardView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var searchBarView: SearchBarView = {
        let searchBarView = SearchBarView()
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        return searchBarView
    }()
    
    lazy var bookemonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Bookemon"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.backgroundColor = .white
        addSubview(bookemonLabel)
        addSubview(searchBarView)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            bookemonLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            bookemonLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            searchBarView.topAnchor.constraint(equalTo: bookemonLabel.bottomAnchor, constant: 8),
            searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
