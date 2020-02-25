//
//  DetailViewController.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    var detailView = DetailView()

    override func loadView() {
        view = detailView
    }
    override func viewDidLoad() {
        view.backgroundColor = .systemTeal
        
    }
     
    
}
