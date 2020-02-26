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
        return search
    }()
    
    public lazy var citySearch: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Enter City Name"
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
        backgroundColor = .systemBackground
        setupView()
        setUpVenueSearchConstraints()
        setupButton()
        setUpCitySearchConstraints()
        setUpMapViewConstraints()
    }
    
    private func setupView() {
        addSubview(view)
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: citySearch.intrinsicContentSize.height * 2)])
    }
    
    private func setupButton() {
        view.addSubview(expansionButton)
        expansionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            expansionButton.topAnchor.constraint(equalTo: venueSearch.bottomAnchor),
            expansionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            expansionButton.heightAnchor.constraint(equalToConstant: citySearch.intrinsicContentSize.height),
            expansionButton.widthAnchor.constraint(equalTo: expansionButton.heightAnchor, multiplier: 1)])
    }
    
    private func setUpVenueSearchConstraints() {
        view.addSubview(venueSearch)
        
        venueSearch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueSearch.topAnchor.constraint(equalTo: view.topAnchor),
            venueSearch.leadingAnchor.constraint(equalTo: leadingAnchor),
            venueSearch.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setUpCitySearchConstraints() {
        view.addSubview(citySearch)
        
        citySearch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            citySearch.topAnchor.constraint(equalTo: venueSearch.bottomAnchor),
            citySearch.leadingAnchor.constraint(equalTo: leadingAnchor),
            citySearch.trailingAnchor.constraint(equalTo: expansionButton.leadingAnchor)
        ])
    }
    
    private func setUpMapViewConstraints() {
        addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
