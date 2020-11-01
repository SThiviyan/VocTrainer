//
//  CustomCell.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 25.10.20.
//

import UIKit

class CustomCell: UICollectionViewCell
{
    static let reuseidentifier = "CustomCell"
    
    public let TextField = UITextField()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemBackground
        
        TextField.textAlignment = .center
        addSubview(TextField)
        
        TextField.frame = contentView.bounds
        TextField.delegate = self
    }
    
    
}


extension CustomCell: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField) {
        TextField.text = textField.text
    }
    
}
