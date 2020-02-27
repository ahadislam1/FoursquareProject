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
    
    public lazy var view: UIView = {
        let view = UIView()
        return view
    }()
    
    public lazy var venueSearch: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Enter a search term.."
        search.layer.cornerRadius = 10
        search.layer.masksToBounds = true
        return search
    }()
    
    public lazy var citySearch: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Enter City Name"
        search.layer.cornerRadius = 10
        search.layer.masksToBounds = true
        return search
    }()
    
    public lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    public lazy var expansionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "table"), for: .normal)
        return button
    }()
    
    public lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
      let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
    cv.alpha = 0.0
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
        backgroundColor = .systemBackground
        setUpMapViewConstraints()
        setUpViewConstraints()
        setUpVenueSearchConstraints()
        setUpCitySearchConstraints()
        setUpCVConstraints()
    }
    
    private func setUpMapViewConstraints() {
        addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpCVConstraints() {
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setUpViewConstraints() {
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func setUpVenueSearchConstraints() {
        addSubview(venueSearch)
        
        venueSearch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueSearch.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            venueSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            venueSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setUpCitySearchConstraints() {
        addSubview(citySearch)
        
        citySearch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            citySearch.topAnchor.constraint(equalTo: venueSearch.bottomAnchor, constant: 8),
            citySearch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            citySearch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
}
