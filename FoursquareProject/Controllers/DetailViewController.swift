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
    }
    
    private func updateUI(with venue: Venue){
       getImage(with: venue)
        
        detailView.nameLabel.text = venue.name
        
        detailView.addressArray0.text = venue.location.formattedAddress[0]
        
        detailView.addressArray1.text = venue.location.formattedAddress[1]
        
        detailView.addressArray2.text = venue.location.formattedAddress[2]
    }
    
    private func getImage(with venue: Venue) {
        
        let venueID = venue.id
               let endpointURL = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(Secret.appId)&client_secret=\(Secret.appSecret)&v=20200221"
               
               var photos = [Item]() {
                   didSet {
                       print("photo count - \(photos.count)")
                   }
               }
               
               GenericCoderAPI.manager.getJSON(objectType: PhotoWrapper.self, with: endpointURL) { result in
                   switch result {
                   case .failure(let error):
                       print(error)
                   case .success(let wrapper):
                       photos = wrapper.response.photos.items
                   }
               }
               
               guard let item = photos.first else { return }
               
               print(" imageUrL = \(item.getImageUrl(imageSize: "400*250"))")
               
               detailView.imageView.getImage(with: item.getImageUrl(imageSize: "original"), writeTo: .cachesDirectory) { [weak self] (result) in
                   switch result {
                   case .failure:
                       DispatchQueue.main.async {
                           self?.detailView.imageView.image = UIImage(named: "buffet")
                       }
                   case .success( let image):
                    
                           DispatchQueue.main.async {
                               self?.detailView.imageView.image = image
                           }
                       }
                   }
               }
        
    }
        
    
    


