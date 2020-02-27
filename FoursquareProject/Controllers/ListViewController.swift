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
    private let venues: [Venue]
    
    init(_ dataPersistence: DataPersistence<FavoriteVenue>, venues: [Venue]) {
        self.dataPersistence = dataPersistence
        self.venues = venues
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
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Title"
    }
    
    
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let restaurant = venues[indexPath.row]
        navigationController?.pushViewController(DetailViewController(dataPersistence, venue: restaurant), animated: true)
      
        
        print(restaurant.location.formattedAddress?.description ?? "No address")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = venues[indexPath.row].name
        return cell
    }
    
}
