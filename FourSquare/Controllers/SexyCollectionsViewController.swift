//
//  CollectionsViewController.swift
//  FourSquare
//
//  Created by Anthony Gonzalez on 11/18/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class SexyCollectionsViewController: UIViewController {
    
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        return button
    }()
    
    lazy var eroticCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(CreatedCollectionViewCell.self, forCellWithReuseIdentifier: "CreatedCell")
        collection.backgroundColor = .clear
        collection.delegate = self
        return collection
    }()
    
    
    @objc func addButtonPressed() {
        let createVC = SexyCreateViewController()
        
        navigationController?.pushViewController(createVC, animated: true)
    }
    
    var createdVenues = [Venue]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = addButton
        
    }
}

extension SexyCollectionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return createdVenues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = eroticCollectionView.dequeueReusableCell(withReuseIdentifier: "CreatedCell", for: indexPath) as! CreatedCollectionViewCell
        
        return cell
    }
    
    
}

extension SexyCollectionsViewController: UICollectionViewDelegateFlowLayout {
    
}
