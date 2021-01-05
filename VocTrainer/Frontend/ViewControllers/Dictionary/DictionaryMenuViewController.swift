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
    
    var AllLanguages = [String]()
    
    //Words that are shown in the Tableview
    var Words = [String]()
    var filteredListItems = [String]()
 
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
        
       
        searchcontroller.searchBar.showsScopeBar = true
        searchcontroller.searchBar.sizeToFit()
        searchcontroller.obscuresBackgroundDuringPresentation = false
        

       
        
        SetLayout()
        //initializeHideKeyboard()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        
        let TempItems = DataManager.LoadAll(WordList.self)
        
        for Num in 0..<TempItems.count {
            ListItems.append(ListItem(name: TempItems[Num].name, TimeAdded: TempItems[Num].TimeAdded, LanguageOne: TempItems[Num].LanguageOne, LanguageTwo: TempItems[Num].LanguageTwo, LanguageOneList: TempItems[Num].WordsLanguageOne, LanguageTwoList: TempItems[Num].WordsLanguageTwo))
        }
        
        
        SetupLanguagesArray()
        
        searchcontroller.searchBar.scopeButtonTitles = AllLanguages
        
        AddWordstoTableView()

    }
    
    func SetupLanguagesArray()
    {
    
        
        for item in 0..<ListItems.count
        {
            AllLanguages.append(ListItems[item].LanguageOne)
            AllLanguages.append(ListItems[item].LanguageTwo)
        }
        
       
        //Important!!!! Removes all double from Array
        AllLanguages = Array(Set(AllLanguages))
        
        AllLanguages = AllLanguages.sorted(by: {
            $0 < $1
        })
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
        
        filterContentForSearchText(searchcontroller.searchBar.text ?? "Empty")
        
        if(searchcontroller.searchBar.text == "")
        {
            AddWordstoTableView()
            TableView.reloadData()
        }
        
    }
    
    
    func filterContentForSearchText(_ searchText: String) {
       
        filteredListItems = Words.filter { Words -> Bool in
        return Words.lowercased().contains(searchText.lowercased())
       }
        
       Words = filteredListItems
        
       
       TableView.reloadData()
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        AddWordstoTableView()
        TableView.reloadData()
    }
    
}

extension DictionaryMenuViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell()
        
        if(Words.count == tableView.numberOfRows(inSection: 0))
        {
          cell.SetupWithListItem(Item: Words[indexPath.row])
        }
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = WordViewController()
        //vc.navigationBar.prefersLargeTitles = true
        vc.SetupTitle(titleOfVC: Words[indexPath.row])
        
        present(vc, animated: true, completion: nil)
    }
    
    
    
    func SetupTableViewWords(LanguageOne: String) -> [String]
    {
       var Words = [String]()
        
        for item in 0..<ListItems.count
        {
            if(ListItems[item].LanguageOne == LanguageOne)
            {
                Words.append(contentsOf: ListItems[item].LanguageOneList)
            }
            else if(ListItems[item].LanguageTwo == LanguageOne)
            {
                Words.append(contentsOf: ListItems[item].LanguageTwoList)
            }
        }
        
        Words = Array(Set(Words))
        
        Words = Words.sorted(by: {
            $0 < $1
        })
        
       return Words
    }
    
    func AddWordstoTableView()
    {
        let indexNum = searchcontroller.searchBar.selectedScopeButtonIndex
        if(indexNum > -1)
        {
        Words = SetupTableViewWords(LanguageOne: AllLanguages[indexNum])
        }
    }
    
    
}



class WordViewController: UIViewController
{
    let TitleLabel: UILabel =
        {
           let label = UILabel()
            label.font = .boldSystemFont(ofSize: 37)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
    
    let AnotherLabel: UILabel =
        {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 15)
            label.text = "All translations found:"
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
    
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
        //title = "Your Word:"
        
            
      
        
    }
    
    func SetupTitle(titleOfVC: String)
    {
        view.addSubview(TitleLabel)
        TitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        TitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        TitleLabel.text = titleOfVC
        
        SetupOtherLabels()
    }
    
    
    func SetupOtherLabels()
    {
        view.addSubview(AnotherLabel)
        AnotherLabel.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: 40).isActive = true
        AnotherLabel.leadingAnchor.constraint(equalTo: TitleLabel.leadingAnchor).isActive = true
        
    }
    
    @objc func dismissViewController()
    {
        dismiss(animated: true, completion: nil)
    }
    
    

}

