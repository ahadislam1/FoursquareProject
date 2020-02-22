//
//  CoreLocationSession.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/22/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationSession: NSObject {
    
    public var locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        startSigLocationChanges()
        
        startMonitoringRegion()
    }
    
    private func startSigLocationChanges(){
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            return
        }
        
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    public func convertCoordinateToPlacemark(coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("reverseGeocodeLocation: \(error)")
            }
            
        }
    }
    
    public func convertPlacemarkToCoordinate(addressString: String) {
        CLGeocoder().geocodeAddressString(addressString) { (placemarks, error) in
            if let error = error {
                print("geocodeAddressString: \(error)")
            }
        }
    }
    
    private func startMonitoringRegion() {
    }
    
}

extension CoreLocationSession: CLLocationManagerDelegate {
    
}
