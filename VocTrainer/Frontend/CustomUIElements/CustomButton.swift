//
//  CustomButton.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 14.10.20.
//

import UIKit

class CustomButton: UIButton
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        SetupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SetupButton()
    }
    
    
    func SetupButton()
    {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        layer.cornerRadius = 20
    }
    
}
