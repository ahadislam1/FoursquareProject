//
//  SearchView.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import MapKit

class SearchView: UIView {
    
    public lazy var venueSearch: UISearchBar = {
        let search = UISearchBar()
        return search
    }()
    
    public lazy var citySearch: UISearchBar = {
        let search = UISearchBar()
        return search
    }()
    
    public lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    public lazy var expansionButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    public lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
      let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
      cv.backgroundColor = .systemGroupedBackground
      return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpVenueSearchConstraints()
        setUpCitySearchConstraints()
        setUpMapViewConstraints()
    }
    
    private func setUpVenueSearchConstraints() {
        addSubview(venueSearch)
        
        venueSearch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueSearch.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            venueSearch.leadingAnchor.constraint(equalTo: leadingAnchor),
            venueSearch.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setUpCitySearchConstraints() {
        addSubview(citySearch)
        
        citySearch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            citySearch.topAnchor.constraint(equalTo: venueSearch.bottomAnchor),
            citySearch.leadingAnchor.constraint(equalTo: leadingAnchor),
            citySearch.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setUpMapViewConstraints() {
        addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: citySearch.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
