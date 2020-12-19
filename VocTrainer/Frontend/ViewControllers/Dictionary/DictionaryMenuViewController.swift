//
//  DictionaryViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 15.10.20.
//

import UIKit

//just to commit files to github

class DictionaryMenuViewController: UIViewController {
    
    var ListItems = [ListItem]()
    let ListStrings = [String]()

 
    let TableView : UITableView =
        {
            let tableView = UITableView(frame: .zero, style: .insetGrouped)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.allowsSelection = true
            tableView.showsVerticalScrollIndicator = true
            
            
            
            return tableView
        }()
    
    let searchcontroller = UISearchController(searchResultsController: nil)
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        let TempItems = DataManager.LoadAll(WordList.self)
        
        for Num in 0..<TempItems.count {
            ListItems.append(ListItem(name: TempItems[Num].name, TimeAdded: TempItems[Num].TimeAdded, LanguageOne: TempItems[Num].LanguageOne, LanguageTwo: TempItems[Num].LanguageTwo, LanguageOneList: TempItems[Num].WordsLanguageOne, LanguageTwoList: TempItems[Num].WordsLanguageTwo))
        }
        
        
        view.addSubview(TableView)

    
        title = "Dictionary"
    
        TableView.delegate = self
        TableView.dataSource = self
        
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchcontroller
        searchcontroller.automaticallyShowsCancelButton = true
        searchcontroller.searchBar.delegate = self
        searchcontroller.searchBar.placeholder = "Search..."
        searchcontroller.searchBar.barStyle = .default
        searchcontroller.searchResultsUpdater = self
        searchcontroller.hidesNavigationBarDuringPresentation = false
        searchcontroller.automaticallyShowsScopeBar = true
        navigationItem.hidesSearchBarWhenScrolling = false
                
        
        SetLayout()
        //initializeHideKeyboard()
        
    }
    
   
    
    func SetLayout()
    {
            
        TableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        TableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        TableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    
        
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
        searchcontroller.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchcontroller.searchBar.endEditing(true)
    }
    
}


extension DictionaryMenuViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}

extension DictionaryMenuViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell()
        cell.SetupWithListItem(Item: ListItems[0])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UINavigationController(rootViewController: WordViewController())
        vc.navigationBar.prefersLargeTitles = true
        
        
        let vc2 = WordViewController()
    
        present(vc, animated: true, completion: nil)
    }
    
    

    
}


class WordViewController: UIViewController
{
    
    let WordOne: UILabel =
        {
            let label = UILabel()
            label.font = .italicSystemFont(ofSize: 15)
            label.textColor = .green
            
            return label
        }()
    
    let WordTwo: UILabel =
        {
            let label = UILabel()
            label.font = .italicSystemFont(ofSize: 15)
            label.textColor = .green
            
            return label
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Your Word:"
        
            
      
        
    }
    
    
    
    
    @objc func dismissViewController()
    {
        dismiss(animated: true, completion: nil)
    }
    
    

}

