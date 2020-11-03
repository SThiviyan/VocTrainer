//
//  DictionaryViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 15.10.20.
//

import UIKit

//just to commit files to github

class DictionaryMenuViewController: UIViewController {
    let Searchbar: UISearchBar =
        {
            let Searchbar = UISearchBar()
            Searchbar.placeholder = "Search in your Dictionary"
            Searchbar.barStyle = .default
            Searchbar.translatesAutoresizingMaskIntoConstraints = false
            Searchbar.showsCancelButton = true
            //Searchbar.setShowsCancelButton(true, animated: true)
            
            return Searchbar
        }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(Searchbar)
    
        SetLayout()
        
    }
    
    
    func SetLayout()
    {
        Searchbar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Searchbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        Searchbar.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        Searchbar.heightAnchor.constraint(equalToConstant: 50).isActive = true
      
        
    
        
    }
    
    
}
