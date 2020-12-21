//
//  PreQuizViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 19.12.20.
//

import UIKit


class PreQuizViewController: UIViewController
{
    
    var CurrentListItem: ListItem!
    
    var Label: UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .systemRed
            return label
        }()
    
    let Button: CustomButton =
        {
            let Button = CustomButton()
            Button.setTitle("Start Quiz", for: .normal)
            
            return Button
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let EditItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(BarButtonTapped))
        
        navigationItem.rightBarButtonItem = EditItem
        
                
        SetupHierachy()
        
        view.addSubview(Label)
        Label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func SetupHierachy()
    {
        view.addSubview(Button)
        
        Button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        Button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        Button.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    public func SetupListItem(List: ListItem)
    {
        CurrentListItem = ListItem(name: List.name, TimeAdded: List.TimeAdded, LanguageOne: List.LanguageOne, LanguageTwo: List.LanguageTwo, LanguageOneList: List.LanguageOneList, LanguageTwoList: List.LanguageTwoList)
        Label.text = List.name
        print(List)
    }
    
}


extension PreQuizViewController
{
    @objc func BarButtonTapped()
    {
        
    }
    
    
}
