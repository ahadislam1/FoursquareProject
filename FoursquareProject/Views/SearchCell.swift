//
//  searchCell.swift
//  FoursquareProject
//
//  Created by Maitree Bain on 2/26/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import ImageKit

class SearchCell: UICollectionViewCell {
    
    public lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "map")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpImageViewConstraints()
    }
    
    private func setUpImageViewConstraints() {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    public func configureCell(for venue: Venue) {
        
        GenericCoderAPI.manager.getJSON(objectType: PhotoWrapper.self, with: "https://api.foursquare.com/v2/venues/\(venue.id)/photos?client_id=\(Secret.appId)&client_secret=\(Secret.appSecret)&v=20200221") { (result) in
            
            switch result {
            case .failure(let appError):
                print("no images found: \(appError)")
            case .success(let photo):
                let images = photo.response.photos.items.map {$0.getImageUrl(imageSize: "300x300")}
                guard let singleImage = images.first else { return }
                DispatchQueue.main.async {
                    self.imageView.getImage(with: singleImage) { (result) in
                        
                        switch result {
                        case .failure:
                            print("image cannot load")
                        case .success(let image):
                            DispatchQueue.main.async {
                                self.imageView.image = image
                            }
                        }
                    }
                }
            }
        }
    }
    
}
