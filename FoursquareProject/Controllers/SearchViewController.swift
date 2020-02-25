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
    private var coordinate = CLLocationCoordinate2DMake(40.123, -70.345) {
        didSet {
            print(coordinate)
        }
    }
    
    private var locationSession = CoreLocationSession()
    private var citySearch = "" {
        didSet {
            convertPlacenameToCoordinate(citySearch)
        }
    }
    
    private let dataPersistence: DataPersistence<FavoriteVenue>
    
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
    
    private func convertPlacenameToCoordinate(_ placename: String) {
        locationSession.convertPlacemarkToCoordinate(addressString: placename) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("error: \(error)")
            case .success(let coordinate):
               
                
                self?.coordinate = coordinate
                
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
                
                self?.searchView.mapView.setRegion(region, animated: true)
            }
        }
    }
    


}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let citySearchText = searchBar.text,
        !citySearchText.isEmpty else {
            return
        }
        
        if searchBar == searchView.citySearch {
        citySearch = citySearchText
            searchBar.text = ""
        }
        
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
}

//extension SearchViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//
//
//}

extension SearchViewController: MKMapViewDelegate {
    
}

