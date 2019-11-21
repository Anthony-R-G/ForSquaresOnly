//
//  CreatedCollectionViewCell.swift
//  FourSquare
//
//  Created by Anthony Gonzalez on 11/19/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class CreatedCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .purple
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        
        ])
    }
    override init(frame: CGRect) {
          super.init(frame: frame)
          
          setConstraints()
          
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
}
