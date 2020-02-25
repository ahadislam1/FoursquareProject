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
        searchView.collectionView.dataSource = self
        searchView.mapView.delegate = self
    }


}

extension SearchViewController: UISearchBarDelegate {
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    
}

extension SearchViewController: MKMapViewDelegate {
    
}

