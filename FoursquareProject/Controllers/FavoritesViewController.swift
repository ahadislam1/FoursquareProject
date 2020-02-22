//
//  FavoritesViewController.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesViewController: UIViewController {
    
    private let dataPersistence: DataPersistence<Venue>
    private let favoritesView = FavoritesView()
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonPressed))
        return button
    }()
    
    init(_ dataPersistence: DataPersistence<Venue>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
        setupNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataPersistence.delegate = self
        favoritesView.collectionView.delegate = self
        favoritesView.collectionView.dataSource = self
    }
    
    @objc private func buttonPressed() {
        
    }
    
    private func setupNavigationBar() {
        title = "My Collections"
        navigationItem.setRightBarButton(addButton, animated: true)
    }
    

}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritecell", for: indexPath) as? FavoritesCell else {
            return UICollectionViewCell()
        }
//        cell.layer.cornerRadius = 5
//        cell.layer.borderWidth = 5
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.clipsToBounds = true
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 2.3, height: view.frame.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
}

extension FavoritesViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        
    }
}
