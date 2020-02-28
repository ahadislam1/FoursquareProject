//
//  DetailViewController.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence
import MapKit

class DetailViewController: UIViewController{
    
    var detailView = DetailView()
    
    private let dataPersistence: DataPersistence<FavoriteVenue>
    private let venue: Venue
    
    
    init(_ dataPersistence: DataPersistence<FavoriteVenue>, venue: Venue) {
        self.dataPersistence = dataPersistence
        self.venue = venue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = detailView
    }
    override func viewDidLoad() {
        view.backgroundColor = .systemGroupedBackground
        updateUI(with: venue)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pushCreateViewController))
        
    }
    
    @objc private func pushCreateViewController() {
        
        let createCV = CreateViewController(dataPersistence: dataPersistence, venue: venue)
        
        navigationController?.pushViewController(createCV, animated: true)
        
    }
    
    private func updateUI(with venue: Venue){
        getImage(with: venue)
        
        
        detailView.nameLabel.text = venue.name
        
        detailView.addressArray0.text = venue.location.formattedAddress?[0]
        
        detailView.addressArray1.text = venue.location.formattedAddress?[1]
        
        setUpMapView(with: venue)
        
    }
    
    private func setUpMapView(with venue: Venue) {
        detailView.directionsButton.titleLabel?.text = "Get Directions"
        detailView.directionsButton.titleLabel?.font = UIFont(name: "Didot", size: 20.0)
        
        let center = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 400, longitudinalMeters: 400)
        
        let annotation = MKPointAnnotation()
        
        annotation.title = venue.name
        annotation.coordinate = CLLocationCoordinate2DMake(Double(venue.location.lat), Double(venue.location.lng))
        
        detailView.mapView.addAnnotation(annotation)
        detailView.mapView.setRegion(region, animated: true)
        
    }
    
    private func getImage(with venue: Venue) {
        
        let venueID = venue.id
        let endpointURL = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(Secret.appId)&client_secret=\(Secret.appSecret)&v=20200221"
        
        
        
        GenericCoderAPI.manager.getJSON(objectType: PhotoWrapper.self, with: endpointURL) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let wrapper):
                let images = wrapper.response.photos.items.map {$0.getImageUrl(imageSize: "original")}
                
                guard let photo = images.first else { return
                    
                }
                DispatchQueue.main.async {
                    self?.detailView.imageView.getImage(with: photo) { (result) in
                        switch result {
                        case .failure:
                            break
                        case .success(let image):
                            
                            DispatchQueue.main.async {
                                self?.detailView.imageView.image = image
                            }
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
