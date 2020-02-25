//
//  ListViewController.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/24/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import DataPersistence

class ListViewController: UIViewController {
    
    private let dataPersistence: DataPersistence<FavoriteVenue>
    private let listView = ListView()
    
    init(_ dataPersistence: DataPersistence<FavoriteVenue>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        title = "Title"
    }
    
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
}
