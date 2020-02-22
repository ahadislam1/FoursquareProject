//
//  TabController.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import DataPersistence

class TabController: UITabBarController {
    
    private let dataPersistence = DataPersistence<Venue>(filename: "favorites.plist")
    
    private lazy var searchVC: SearchViewController = {
        let vc = SearchViewController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return vc
    }()
    
    private lazy var favoritesVC: UINavigationController = {
        let vc = FavoritesViewController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "book"), tag: 1)
        return UINavigationController(rootViewController: vc)
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [searchVC, favoritesVC]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
