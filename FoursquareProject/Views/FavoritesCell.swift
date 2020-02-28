//
//  FavoritesCell.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/22/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Category"
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.font = l.font.withSize(25)
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    public func configureCell(_ venue: FavoriteVenue) {
        titleLabel.text = venue.title
        imageView.layer.cornerRadius = 5
        getImage(with: venue.venue)
    }
    
    private func getImage(with venue: Venue) {
        
        let endpointURL = "https://api.foursquare.com/v2/venues/\(venue.id)/photos?client_id=\(Secret.appId)&client_secret=\(Secret.appSecret)&v=20200221"
        
        var photos = [Item]()
        
        GenericCoderAPI.manager.getJSON(objectType: PhotoWrapper.self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let wrapper):
                photos = wrapper.response.photos.items
            }
        }
        
        guard let item = photos.first else { return }
        
        imageView.getImage(with: item.getImageUrl(imageSize: "300x300"), writeTo: .cachesDirectory) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "photo")
                }
            case .success( let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
    
    private func commonInit() {
        setupImageView()
        setupTitleLabel()
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75)])
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)])
    }
}
