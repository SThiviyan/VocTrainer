//
//  LearnCollectionViewCell.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 14.11.20.
//

import UIKit

class LearnCollectionViewCell: UICollectionViewCell {
    
    static let reuseidentifier = "LearnCustomCell"
    
    let Button = UIButton()
    
    let LanguageLabel = UILabel()
    let LanguageOneLabel = UILabel()
    let LanguageTwoLabel = UILabel()
    let sectionNameLabel = UILabel()
    let NamedSectionLabel = UILabel()
    let NumWordsTitleLabel = UILabel()
    let NumWordsLabel = UILabel()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(Button)
        contentView.addSubview(LanguageLabel)
        contentView.addSubview(LanguageOneLabel)
        contentView.addSubview(LanguageTwoLabel)
        contentView.addSubview(sectionNameLabel)
        contentView.addSubview(NamedSectionLabel)
        contentView.addSubview(NumWordsLabel)
        contentView.addSubview(NumWordsTitleLabel)
        
        
        Button.layer.cornerRadius = 20
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.backgroundColor = .systemBlue
        Button.layer.borderWidth = 2
        Button.layer.borderColor = UIColor.white.cgColor
        Button.setTitle("Learn", for: .normal)
        Button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        
        
        LanguageLabel.translatesAutoresizingMaskIntoConstraints = false
        LanguageLabel.textColor = .white
        LanguageLabel.font = .boldSystemFont(ofSize: 18)
        LanguageLabel.text = "Languages:"
        
        LanguageOneLabel.translatesAutoresizingMaskIntoConstraints = false
        LanguageOneLabel.textColor = .white
        LanguageOneLabel.font = .boldSystemFont(ofSize: 15)
        //LanguageOneLabel.text = "LanguageOne"
        
        LanguageTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        LanguageTwoLabel.textColor = .white
        LanguageTwoLabel.font = .boldSystemFont(ofSize: 15)
        //LanguageTwoLabel.text = "LanguageTwo"
        
        NamedSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NamedSectionLabel.textColor = .white
        NamedSectionLabel.font = .boldSystemFont(ofSize: 15)
        //NamedSectionLabel.text = "SectionName"
        
        sectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionNameLabel.textColor = .white
        sectionNameLabel.font = .boldSystemFont(ofSize: 18)
        sectionNameLabel.text = "Name:"
        
        NumWordsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NumWordsTitleLabel.textColor = .white
        NumWordsTitleLabel.font = .boldSystemFont(ofSize: 18)
        NumWordsTitleLabel.text = "Number of Words:"
        
        NumWordsLabel.translatesAutoresizingMaskIntoConstraints = false
        NumWordsLabel.textColor = .white
        NumWordsLabel.font = .boldSystemFont(ofSize: 15)
        //NumWordsLabel.text = "INT"
        
     
        
        
        
        SetLayout()
      
    }
    
    public func SetupListCell(Item: ListItem)
    {
        NamedSectionLabel.text = Item.name
        LanguageOneLabel.text = Item.LanguageOne
        LanguageTwoLabel.text = Item.LanguageTwo
        NumWordsLabel.text = String(Item.LanguageOneList.count)
    }
   
    func SetLayout()
    {
        Button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        Button.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 5).isActive = true
        Button.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 30).isActive = true
        Button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        
        sectionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        sectionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        
        NamedSectionLabel.leadingAnchor.constraint(equalTo: sectionNameLabel.leadingAnchor).isActive = true
        NamedSectionLabel.topAnchor.constraint(equalTo: sectionNameLabel.bottomAnchor, constant: 15).isActive = true
        
        LanguageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        LanguageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        LanguageOneLabel.topAnchor.constraint(equalTo: LanguageLabel.bottomAnchor, constant: 15).isActive = true
        LanguageOneLabel.trailingAnchor.constraint(equalTo: LanguageLabel.trailingAnchor).isActive = true
        
        LanguageTwoLabel.topAnchor.constraint(equalTo: LanguageOneLabel.bottomAnchor, constant: 10).isActive = true
        LanguageTwoLabel.trailingAnchor.constraint(equalTo: LanguageLabel.trailingAnchor).isActive = true

        
        NumWordsTitleLabel.leadingAnchor.constraint(equalTo: NamedSectionLabel.leadingAnchor).isActive = true
        NumWordsTitleLabel.topAnchor.constraint(equalTo: NamedSectionLabel.bottomAnchor, constant: 40).isActive = true
        
        NumWordsLabel.leadingAnchor.constraint(equalTo: NumWordsTitleLabel.leadingAnchor).isActive = true
        NumWordsLabel.topAnchor.constraint(equalTo: NumWordsTitleLabel.bottomAnchor, constant: 15).isActive = true
        
    
        
    }
    
}
