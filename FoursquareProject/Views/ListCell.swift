//
//  ListCell.swift
//  FoursquareProject
//
//  Created by Maitree Bain on 2/27/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    public lazy var venueImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "tray.and.arrow.down")
        image.tintColor = .black
        image.alpha = 0.8
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    public lazy var venueName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Kefa", size: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setUpVenueImageConstraints()
        setUpViewConstraints()
        setUpNameLabelConstraints()
    }
    
    private func setUpVenueImageConstraints() {
        addSubview(venueImage)
        
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueImage.topAnchor.constraint(equalTo: topAnchor),
            venueImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            venueImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            venueImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpViewConstraints() {
        venueImage.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: venueImage.topAnchor),
            view.leadingAnchor.constraint(equalTo: venueImage.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: venueImage.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: venueImage.bottomAnchor)
        ])
    }
    
    private func setUpNameLabelConstraints() {
        view.addSubview(venueName)
        
        venueName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueName.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            venueName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            venueName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    public func configureCell(for venue: Venue) {
        venueName.text = venue.name
        
        GenericCoderAPI.manager.getJSON(objectType: PhotoWrapper.self, with: "https://api.foursquare.com/v2/venues/\(venue.id)/photos?client_id=\(Secret.appId)&client_secret=\(Secret.appSecret)&v=20200221") { (result) in
            
            switch result {
            case .failure(let appError):
                print("no images found: \(appError)")
            case .success(let photo):
                let images = photo.response.photos.items.map {$0.getImageUrl(imageSize: "300x300")}
                guard let singleImage = images.first else { return }
                DispatchQueue.main.async {
                    self.venueImage.getImage(with: singleImage, writeTo: .cachesDirectory) { (result) in
                        
                        switch result {
                        case .failure:
                            print("image cannot load")
                        case .success(let image):
                            DispatchQueue.main.async {
                                self.venueImage.image = image
                                self.venueImage.alpha = 1.0
                            }
                        }
                    }
                }
            }
        }
    }
    
}
