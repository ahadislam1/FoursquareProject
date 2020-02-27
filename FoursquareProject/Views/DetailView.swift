//
//  DetailView.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

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
        imageView.image = UIImage(named: "buffet")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
        
    }()
    
    public lazy var nameLabel : UILabel = {
        let textView = UILabel()
         textView.backgroundColor = .systemTeal
        textView.numberOfLines = 0
        textView.font = UIFont(name: "Didot", size: 40.0)
        textView.text = " Details Details Details"
       
        return textView
    }()
    public lazy var addressArray0 : UILabel = {
        let textView = UILabel()
         textView.backgroundColor = .systemTeal
        textView.numberOfLines = 0
        textView.font = UIFont(name: "Didot", size: 30.0)
        textView.text = "Info Info Info"
       
        return textView
    }()
    public lazy var addressArray1 : UILabel = {
        let textView = UILabel()
        textView.backgroundColor = .systemTeal
        textView.numberOfLines = 0
        textView.font = UIFont(name: "Didot", size: 30.0)
        textView.text = "Data Data Data"
       
        return textView
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
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.6)


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
}
