//
//  CreateViewController.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    private let createView = CreateView()
    
    override func loadView() {
       view = createView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
    }
    



}
