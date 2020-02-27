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
            if favoriteVenues.isEmpty {
                createView.collectionView.backgroundView = EmptyView(title: "Saved Categories", message: "You haven't saved any venues yet.")
            } else {
                createView.collectionView.backgroundView = nil
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
        validateVenue()
    }
    
    @objc private func buttonPressed() {
        if createButton.image == UIImage(systemName: "bookmark") {
            guard let text = createView.textField.text, !text.isEmpty else {
                let alertvc = UIAlertController.errorAlert("Textfield is empty.")
                present(alertvc, animated: true)
                return
            }
            createButton.image = UIImage(systemName: "bookmark.fill")
            createFavoriteVenue(text.capitalized, venue: venue)
        } else {
            guard let x = ((favoriteVenues.map {$0.venue}).firstIndex{ $0 == venue}) else {
                let alertvc = UIAlertController.errorAlert("Error finding venue.")
                self.present(alertvc, animated: true)
                return
            }
            do {
                try dataPersistence.deleteItem(at: x)
                loadData()
                navigationController?.popViewController(animated: true)
            } catch {
                let alertvc = UIAlertController.errorAlert("Error deleting venue: \(error.localizedDescription)")
                self.present(alertvc, animated: true)
                return
                
            }
        }
    }
    
    private func createFavoriteVenue(_ title: String, venue: Venue) {
        let favoriteVenue = FavoriteVenue(venue: venue, title: title)
        do {
            try dataPersistence.createItem(favoriteVenue)
            navigationController?.popViewController(animated: true)
        } catch {
            let alertvc = UIAlertController.errorAlert("\(error.localizedDescription)")
            present(alertvc, animated: true, completion: nil)
        }
    }
    
    private func validateVenue() {
        if (favoriteVenues.map{$0.venue}).contains(venue) {
            createButton.image = UIImage(systemName: "bookmark.fill")
        } else {
            createButton.image = UIImage(systemName: "bookmark")
        }
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
        navigationItem.setRightBarButton(createButton, animated: true)
    }
    
    
}

extension CreateViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = groupedFavoriteVenuesKeys[indexPath.row]
        createFavoriteVenue(title, venue: venue)
    }
    
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
        CGSize(width: view.frame.width / 2.3, height: view.frame.width / 2.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
    }
}




extension CreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
