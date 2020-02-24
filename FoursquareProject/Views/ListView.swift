//
//  ListView.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/24/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class ListView: UIView {
    
    public lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
    
    
    
}
