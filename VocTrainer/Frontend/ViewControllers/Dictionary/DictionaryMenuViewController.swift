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
    
    
    let TableView : UITableView =
        {
            let tableView = UITableView(frame: .zero, style: .insetGrouped)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.allowsSelection = true
            
            
            
            
            return tableView
        }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(Searchbar)
        view.addSubview(TableView)
    
        Searchbar.delegate = self
        TableView.delegate = self
        TableView.dataSource = self
        
        SetLayout()
        //initializeHideKeyboard()
        
    }
    
   
    
    func SetLayout()
    {
        
        
        Searchbar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Searchbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        Searchbar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: 0).isActive = true
        Searchbar.heightAnchor.constraint(equalToConstant: 50).isActive = true
      
        TableView.topAnchor.constraint(equalTo: Searchbar.bottomAnchor).isActive = true
        TableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        TableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    
        
    }
    
    func initializeHideKeyboard(){
      
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(dismissMyKeyboard))
    
      view.addGestureRecognizer(tap)
     }
       
     @objc func dismissMyKeyboard(){
     view.endEditing(true)
     }
       
    
    
}


extension DictionaryMenuViewController: UISearchBarDelegate
{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        Searchbar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Searchbar.endEditing(true)
    }
    
}


extension DictionaryMenuViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = WordViewController()
        present(vc, animated: true, completion: nil)
    }
    
    

    
}


class WordViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        //title = "Your Word:"
        
        
        let width = self.view.frame.width
              
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
              
        self.view.addSubview(navigationBar);
              
        let navigationItem = UINavigationItem(title: "Your Word:")
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: nil, action: #selector(dismissViewController))
        
        navigationItem.rightBarButtonItem = doneBtn
        navigationBar.setItems([navigationItem], animated: false)
      
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @objc func dismissViewController()
    {
        dismiss(animated: true, completion: nil)
    }
    
    

}

