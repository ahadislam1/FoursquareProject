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
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(label2)
        stackView.addArrangedSubview(label3)
        stackView.addArrangedSubview(label4)
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.backgroundColor = .systemBlue
        return stackView
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.contentMode = .scaleAspectFill

        return imageView
        
    }()
    
    private lazy var label : UILabel = {
        let textView = UILabel()
        textView.backgroundColor = .systemGroupedBackground
        textView.numberOfLines = 0
        textView.font = UIFont(name: "Didot", size: 40.0)
        textView.text = " Details Details Details"
       
        return textView
    }()
    private lazy var label2 : UILabel = {
        let textView = UILabel()
        textView.backgroundColor = .systemGroupedBackground
        textView.numberOfLines = 0
        textView.font = UIFont(name: "Didot", size: 40.0)
        textView.text = "Info Info Info"
       
        return textView
    }()
    private lazy var label3 : UILabel = {
        let textView = UILabel()
        textView.backgroundColor = .systemGroupedBackground
        textView.numberOfLines = 0
        textView.font = UIFont(name: "Didot", size: 40.0)
        textView.text = "Data Data Data"
       
        return textView
    }()
    private lazy var label4 : UILabel = {
        let textView = UILabel()
        textView.backgroundColor = .systemGroupedBackground
        textView.numberOfLines = 0
        textView.font = UIFont(name: "Didot", size: 40.0)
        textView.text = "More Data, Info, & Details"
       
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
        scrollView.addSubview(imageView)
        scrollView.addSubview(stackView)
        

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
//
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100.0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.8)
            
        
        
        ])
        
    }
}
