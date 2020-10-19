//
//  CustomScrollView.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 15.10.20.
//

import UIKit


class CustomScrollView: UIScrollView
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupScrollview()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SetupScrollview()
    }
     
    func SetupScrollview()
    {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        indicatorStyle = .default
    }
}
