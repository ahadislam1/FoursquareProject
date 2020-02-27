//
//  CreateViewController.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import DataPersistence

class CreateViewController: UIViewController {
    
    private let dataPersistence: DataPersistence<FavoriteVenue>
    private let venue: Venue
    private let createView = CreateView()
    
    private lazy var createButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .done, target: self, action: #selector(buttonPressed))
        return button
    }()
    
    private var favoriteVenues = [FavoriteVenue]() {
        didSet {
            createView.collectionView.reloadData()
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
    
    init(dataPersistence: DataPersistence<FavoriteVenue>, venue: Venue) {
        self.dataPersistence = dataPersistence
        self.venue = venue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        createView.collectionView.delegate = self
        createView.collectionView.dataSource = self
        createView.textField.delegate = self
        loadData()
    }
    
    @objc private func buttonPressed() {
        
    }
    
    private func loadData() {
        do {
            favoriteVenues = try dataPersistence.loadItems()
        } catch {
            print(error)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    
}

extension CreateViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupedFavoriteVenues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritecell", for: indexPath) as? FavoritesCell else {
            return UICollectionViewCell()
        }
        
        let venue = groupedFavoriteVenues[indexPath.row][0]
        cell.configureCell(venue)
        
        return cell
    }
}

extension CreateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 2, height: view.frame.width / 2)
    }
}




extension CreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
