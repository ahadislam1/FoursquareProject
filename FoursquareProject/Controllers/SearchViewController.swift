//
//  ViewController.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import DataPersistence
import MapKit

class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private let dataPersistence: DataPersistence<FavoriteVenue>
    private var venues = [Venue]() {
        didSet {
            print(venues.count)
        }
    }
    
    
    init(_ dataPersistence: DataPersistence<FavoriteVenue>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.venueSearch.delegate = self
        searchView.citySearch.delegate = self
        searchView.collectionView.delegate = self
//        searchView.collectionView.dataSource = self
        searchView.mapView.delegate = self
    }
    
    private func loadData(_ query: String) {
        let endpointURL = "https://api.foursquare.com/v2/venues/search?client_id=\(Secret.appId)&client_secret=\(Secret.appSecret)&v=20200221&ll=40.735,-73.78&query=\(query)"
        
        GenericCoderAPI.manager.getJSON(objectType: VenueModel.self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let model):
                self.venues = model.response.venues
            }
        }
    }


}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar == searchView.venueSearch {
            if let text = searchBar.text {
                let query = text.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                loadData(query)
            }
        }
        searchBar.resignFirstResponder()
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
}

//extension SearchViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
    
    
//}

extension SearchViewController: MKMapViewDelegate {
    
}

