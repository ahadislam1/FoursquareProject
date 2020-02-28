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
        detailView.mapView.delegate = self
        
        detailView.directionsButton.addTarget(self, action: #selector(getWalkingDirections), for: .touchUpInside)
        
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
    
  
    
   @objc private func getWalkingDirections() {
        
        detailView.mapView.isUserInteractionEnabled = true
        
        let request = MKDirections.Request()
        
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude:venue.location.lat, longitude: venue.location.lng), addressDictionary: nil))
            request.requestsAlternateRoutes = true
    request.transportType = .automobile

            let directions = MKDirections(request: request)
    
    let overlays = detailView.mapView.overlays
    detailView.mapView.removeOverlays(overlays)

            directions.calculate { [unowned self] response, error in
                guard let unwrappedResponse = response else { return }

                for route in unwrappedResponse.routes {
                    self.detailView.mapView.addOverlay(route.polyline)
                    self.detailView.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                }
            }
        }
    }
    


extension DetailViewController: MKMapViewDelegate {
    
func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
    renderer.strokeColor = UIColor.blue
    return renderer
}
    

    
}
