//
//  CreateViewController.swift
//  FourSquare
//
//  Created by Anthony Gonzalez on 11/19/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class SexyCreateViewController: UIViewController {

    lazy var createTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        textField.placeholder = "Enter some crap here..."
        textField.borderStyle = .bezel
        return textField
        
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    @objc private func createButtonPressed() {
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            createTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            createTextField.heightAnchor.constraint(equalToConstant: 40),
            createTextField.widthAnchor.constraint(equalToConstant: 300),
            
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.centerYAnchor.constraint(equalTo: createTextField.centerYAnchor, constant: 60 ),
            createButton.widthAnchor.constraint(equalToConstant: 60),
            createButton.heightAnchor.constraint(equalToConstant: 30)
        
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        

    }
}
