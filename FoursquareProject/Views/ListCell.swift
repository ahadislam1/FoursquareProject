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
        return image
    }()
    
    private lazy var view: UIView = {
       let view = UIView()
        return view
    }()

    public lazy var venueName: UILabel = {
       let label = UILabel()
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
        
    }
    
}
