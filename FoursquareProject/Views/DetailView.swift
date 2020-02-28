//
//  DetailView.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import MapKit

class DetailView: UIView {

    
    private lazy var scrollView : UIScrollView = {

        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        let screenX = screensize.maxX
        let screenY = screensize.maxY
        let scrollView = UIScrollView(frame: CGRect(x:screenX , y: screenY, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: 2000)
       
        return scrollView
        
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.alignment = .center
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(addressArray0)
        stackView.addArrangedSubview(addressArray1)
       
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    public lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "food")
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        imageView.contentMode = .scaleAspectFill
       
        imageView.layer.cornerRadius = 20
          imageView.clipsToBounds = true

        return imageView
        
    }()
    
    public lazy var nameLabel : UILabel = {
        let textView = UILabel()
         textView.backgroundColor = .systemTeal
        textView.numberOfLines = 0
        textView.textAlignment = .center
        textView.font = UIFont(name: "Didot", size: 45.0)
        textView.text = " Details Details Details"
       
        return textView
    }()
    public lazy var addressArray0 : UILabel = {
        let textView = UILabel()
         textView.backgroundColor = .systemTeal
        textView.textAlignment = .center
        textView.numberOfLines = 0
        textView.font = UIFont(name: "Didot", size: 30.0)
        textView.text = "Info Info Info"
       
        return textView
    }()
    public lazy var addressArray1 : UILabel = {
        let textView = UILabel()
        textView.backgroundColor = .systemTeal
        textView.numberOfLines = 0
        textView.textAlignment = .center
        textView.font = UIFont(name: "Didot", size: 30.0)
        textView.text = "Data Data Data"
       
        return textView
    }()
    
    public lazy var mapView : MKMapView = {
        let mapView = MKMapView()
        mapView.layer.borderWidth = 10
        mapView.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        mapView.isUserInteractionEnabled = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    public lazy var directionsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Get Directions", for: .normal)
        
        button.backgroundColor = .black
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Didot", size: 20.0)
        return button
    }()
 

    override init(frame: CGRect) {
        super.init(frame:UIScreen.main.bounds)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commomInit()
    }
    
    private func commomInit() {
        setUpScrollViewConstraints()

       
}

    func setUpScrollViewConstraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setUpImageView()
        setUpStackView()
        setUpMapView()
        setUpDirectionsButton()
    }
    
    
    func setUpStackView() {
        scrollView.addSubview(stackView)
        stackView.backgroundColor = .systemPink
        stackView.translatesAutoresizingMaskIntoConstraints = false
//
        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.4)


        ])
    
}
    
    func setUpImageView() {
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10.0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.5)
            
        
        ])
        
    }
    
    func setUpMapView() {
        scrollView.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            mapView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        
        
        
        ])
    }
    
    private func setUpDirectionsButton() {
        
        scrollView.addSubview(directionsButton)
        directionsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            directionsButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 100),
            directionsButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            directionsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            directionsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100)
            
            
        ])
        
    }
}
