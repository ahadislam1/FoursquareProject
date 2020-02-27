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
    private var locationSession = CoreLocationSession()
    private var userTrackingButton: MKUserTrackingButton!
    private var coordinate = CLLocationCoordinate2DMake(40.739658, -73.7901582) {
        didSet {
            print(coordinate)
        }
    }
    
    private var citySearch = "" {
        didSet {
            convertPlacenameToCoordinate(citySearch)
        }
    }
    
    private var venues = [Venue]() {
        didSet {
            DispatchQueue.main.async {
                self.loadMapView()
                self.searchView.collectionView.reloadData()
                self.searchView.collectionView.alpha = 1.0
            }
        }
    }
    
    private var images = [Item]() {
        didSet {
            DispatchQueue.main.async {
                self.loadView()
                self.searchView.collectionView.reloadData()
            }
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
    
    var placeholderText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        configureSearchView()
        searchView.venueSearch.delegate = self
        searchView.citySearch.delegate = self
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "searchCell")
        searchView.mapView.delegate = self
        searchView.mapView.showsUserLocation = true
        userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 20, y: 30, width: 40, height: 40))
        searchView.mapView.addSubview(userTrackingButton)
        userTrackingButton.mapView = searchView.mapView
        searchView.mapView.showsCompass = true
        citySearch = "fresh meadows"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func buttonPressed() {
        navigationController?.pushViewController(ListViewController(dataPersistence, venues: venues), animated: true)
    }
    
    private func configureSearchView() {
        searchView.expansionButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    private func loadData(_ query: String) {
        
        let endpointURL = "https://api.foursquare.com/v2/venues/search?client_id=\(Secret.appId)&client_secret=\(Secret.appSecret)&v=20200221&ll=\(coordinate.latitude),\(coordinate.longitude)&query=\(query)&radius=2000&limit=10"
        
        GenericCoderAPI.manager.getJSON(objectType: VenueModel.self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let model):
                self.venues = model.response.venues
            }
        }
    }
    
    private func convertPlacenameToCoordinate(_ placename: String) {
        locationSession.convertPlaceNameToCoordinate(addressString: placename) { [weak self] (result) in
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
    
    private func createAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        venues.forEach({
            let point = MKPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: $0.location.lat, longitude: $0.location.lng)
            point.title = $0.name
            annotations.append(point)
        })
        return annotations
    }
    
    private func loadMapView() {
        searchView.mapView.showAnnotations(createAnnotations(), animated: true)
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
           placeholderText = citySearchText
            searchBar.placeholder = "Recent city search : \(placeholderText)"
            searchBar.text = ""
        } else if searchBar == searchView.venueSearch {
            if let text = searchBar.text {
                let query = text.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                loadData(query)
            }
        }
        
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 1
        let maxWidth = CGFloat(80)
        let numberOfItems: CGFloat = 1
        let totalSpace: CGFloat = numberOfItems * itemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpace) / numberOfItems
        
        return CGSize(width: itemWidth, height: 80)
    }

}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("could not downcast to SearchCell")
        }
        let venue = venues[indexPath.row]
        if searchView.collectionView.alpha == 0.0 {
            cell.backgroundColor = .clear
        }else {
            cell.backgroundColor = .black
            cell.layer.cornerRadius = 10
        }
        cell.configureCell(for: venue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let venueItem = venues[indexPath.row]
        let detailVC = DetailViewController(dataPersistence, venue: venueItem)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension SearchViewController: MKMapViewDelegate {
    
}

