//
//  TableViewCell.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 06.11.20.
//

import UIKit



class TableViewCell: UITableViewCell
{
    
    let accessoryImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension TableViewCell
{
    func configure()
    {
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        accessoryImageView.image = UIImage(systemName: "chevron.right")
        accessoryImageView.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
        contentView.addSubview(accessoryImageView)
        
        accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        accessoryImageView.widthAnchor.constraint(equalToConstant: 13).isActive = true
        accessoryImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        
    }
    
    
}
