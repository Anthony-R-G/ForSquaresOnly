//
//  SearchCollectionViewCell.swift
//  FourSquare
//
//  Created by Anthony Gonzalez on 11/18/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image.layer.cornerRadius = 15
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setConstraints() {
        contentView.addSubview(image)
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
    }
    
    
}
