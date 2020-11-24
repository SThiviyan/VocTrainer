//
//  CustomCell.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 25.10.20.
//

import UIKit


//just to commit files to github

class CustomCell: UICollectionViewCell
{
    static let reuseidentifier = "CustomCell"
    
    public let TextField = UITextField()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemBackground
        
        TextField.textAlignment = .center
        addSubview(TextField)
        
        
        TextField.autocapitalizationType = .none
        TextField.enablesReturnKeyAutomatically = true
        TextField.autocorrectionType = .default
        TextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            TextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            TextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            TextField.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            TextField.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        
        ])
        
    }
    
    
}





