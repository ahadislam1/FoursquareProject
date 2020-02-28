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
    
    private let dataPersistence: DataPersistence<FavoriteVenue>
    private let favoritesView = FavoritesView()
    private var favoriteVenues = [FavoriteVenue]() {
        didSet {
            favoritesView.collectionView.reloadData()
            if favoriteVenues.isEmpty {
                favoritesView.collectionView.backgroundView = EmptyView(title: "Saved Categories", message: "You haven't saved any venues yet.")
            } else {
                favoritesView.collectionView.backgroundView = nil
            }
        }
    }
    
    private var groupedFavoriteVenuesKeys: [String] {
        Dictionary(grouping: favoriteVenues) { $0.title }
            .sorted {$0.key < $1.key }
            .map {$0.key}
    }
    
    private var groupedFavoriteVenues: [[FavoriteVenue]] {
        Dictionary(grouping: favoriteVenues) { $0.title }
            .sorted {$0.key < $1.key }
            .map {$0.value}
    }
    
    init(_ dataPersistence: DataPersistence<FavoriteVenue>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.dataPersistence = DataPersistence<FavoriteVenue>(filename: "favorites.plist")
        super.init(coder: coder)
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
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func loadData() {
        do {
            favoriteVenues = try dataPersistence.loadItems()
        } catch {
            print(error)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "My Collections"
    }

}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let venues = groupedFavoriteVenues[indexPath.row].map { $0.venue }
        let vc = ListViewController(dataPersistence, venues: venues)
        vc.title = groupedFavoriteVenuesKeys[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        groupedFavoriteVenues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritecell", for: indexPath) as? FavoritesCell else {
            return UICollectionViewCell()
        }
        
        let venue = groupedFavoriteVenues[indexPath.row][0]
        cell.configureCell(venue)
        
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
        loadData()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadData()
    }
}
