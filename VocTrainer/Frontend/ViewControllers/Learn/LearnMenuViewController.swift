//
//  LearnMenuViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 15.10.20.
//

import UIKit

//just to commit files to github

class LearnMenuViewController: UIViewController
{
 
  
    enum Section {
        case main
    }
    
    var collectionView: UICollectionView! = nil
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, ListItem>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, ListItem>
    
    
    let button: UIButton =
        {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "plus.circle" ), for: UIControl.State.normal)
            button.tintColor = .systemBackground
            button.imageView?.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 25
            return button
        }()

    var dataSource: DataSource!
    var snapshot = DataSourceSnapshot()
    
    var Items = [ListItem]()
    var Openings = Int()
    
   
    let searchcontroller = UISearchController(searchResultsController: nil)
    var filteredListItems = [ListItem]()


    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        title = "Learn"
        view.backgroundColor = .systemBackground
                    
    
        configureHierarchy()
        configureDataSource()
    
        SetupButton()
        SetupBarButton()
        SetupBarSearchBar()
    }
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        UserDefaults.standard.setValue(Openings, forKey: "Comparison")
        
        if(Openings != DataManager.GetTotalNum(WordList.self))
        {
          loaddata()
        }
    }

    
    
}


extension LearnMenuViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating
{
    
    func SetupBarSearchBar()
    {
        navigationItem.searchController = searchcontroller
        navigationItem.searchController?.automaticallyShowsCancelButton = true
        navigationItem.searchController?.delegate = self
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.searchController?.searchBar.placeholder = "Search..."
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.definesPresentationContext = true
    }
    
    var isSearchBarEmpty: Bool
    {
        return searchcontroller.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredListItems = Items.filter { (Items: ListItem) -> Bool in
        return Items.name.lowercased().contains(searchText.lowercased())
      }
        
      
        applySnapshot(Sections: filteredListItems)
    }
    
    
 
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
                
        //applySnapshot(Sections: Items)
        print(Items)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    
}


extension LearnMenuViewController
{
    //All the Corrresponding Button Code
    
    func SetupButton()
    {
        view.addSubview(button)
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 55).isActive = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        button.imageView?.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        button.imageView?.topAnchor.constraint(equalTo: button.topAnchor).isActive = true
        button.imageView?.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        button.imageView?.rightAnchor.constraint(equalTo: button.rightAnchor).isActive = true
        button.imageView?.leftAnchor.constraint(equalTo: button.leftAnchor).isActive = true
        
        button.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func ButtonTapped()
    {
        //Uncomment Comment below if viewcontroller has to change(proprietary)
        //let vc = AddWordsViewController()
        //vc.modalPresentationStyle = .fullScreen
        //navigationController?.pushViewController(vc, animated: true)
        
    
        let TypeAction = UIAlertAction(title: "Type in",
                    style: .default) { (action) in
           // Respond to user selection of the action
            let vc = PickLanguagesViewcontroller()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
          }
        
        let ScanAction = UIAlertAction(title: "Scan", style: .default) {
            (action) in
            let vc = ScanWordsViewController()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
          
        let cancelAction = UIAlertAction(title: "Cancel",
                    style: .cancel) { (action) in
           // Respond to user selection of the action
        }
        
        
        let alert = UIAlertController(title: "How do you want to add Words?",
                      message: "",
           preferredStyle: .actionSheet)
        
        alert.addAction(TypeAction)
        alert.addAction(ScanAction)
        alert.addAction(cancelAction)
               
        
               
        self.present(alert, animated: true) {
             // The alert was presented
        }
    }
    
    
    
    func SetupBarButton()
    {
        let SortBtn = UIBarButtonItem(image: UIImage(systemName: "tray.full"), style: .done, target: self, action: #selector(BarButtonPressed))
        navigationItem.rightBarButtonItem = SortBtn
    }
    
    @objc func BarButtonPressed()
    {
        
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            (action) in
            
        }
        
        let SortByNameAction = UIAlertAction(title: "Name", style: .default)
        {
            (action) in
            
            self.SortItemsByName()
        }
        
        let SortByDate = UIAlertAction(title: "Date", style: .default)
        {
            (action) in
            
            self.SortItemsByDate()
        }
        
        let SortByMostWords = UIAlertAction(title: "Most Words", style: .default)
        {
            (action) in
            
            self.SortItemsByMostWords()
        }
        
        let SortByLeastWords = UIAlertAction(title: "Least Words", style: .default)
        {
            (action) in
            
            self.SortItemsByLeastWords()
        }
        
        let Alert = UIAlertController(title: "Sorting Items by", message: "", preferredStyle: .actionSheet)
        
        Alert.addAction(CancelAction)
        Alert.addAction(SortByNameAction)
        Alert.addAction(SortByDate)
        Alert.addAction(SortByMostWords)
        Alert.addAction(SortByLeastWords)
        
        self.present(Alert, animated: true)
        
    }
    
    
    func SortItemsByName()
    {
        Items = Items.sorted(by: {
            $0.name < $1.name
        })
        
        applySnapshot(Sections: Items)
    }
   
    func SortItemsByDate()
    {
        Items = Items.sorted(by: {
            $0.TimeAdded < $1.TimeAdded
        })
        
        applySnapshot(Sections: Items)
    }
    
    func SortItemsByMostWords()
    {
        Items = Items.sorted(by: {
            $0.LanguageOneList.count > $1.LanguageOneList.count
        })
        
        applySnapshot(Sections: Items)
    }
    
    func SortItemsByLeastWords()
    {
        Items = Items.sorted(by: {
            $0.LanguageOneList.count < $1.LanguageOneList.count
        })
        
        applySnapshot(Sections: Items)
    }
}


extension LearnMenuViewController
{
    
    func loaddata()
    {
        
        let TempItems = DataManager.LoadAll(WordList.self)
            .sorted(by: {
            $0.TimeAdded < $1.TimeAdded
        })
        
        
       if(Openings == 0)
       {
        for Num in 0..<TempItems.count {
            Items.append(ListItem(name: TempItems[Num].name, TimeAdded: TempItems[Num].TimeAdded, LanguageOne: TempItems[Num].LanguageOne, LanguageTwo: TempItems[Num].LanguageTwo, LanguageOneList: TempItems[Num].WordsLanguageOne, LanguageTwoList: TempItems[Num].WordsLanguageTwo))
         }
        
       }
    else
       {
        Items.append(ListItem(name: TempItems[TempItems.count - 1].name, TimeAdded: TempItems[TempItems.count - 1].TimeAdded, LanguageOne: TempItems[TempItems.count - 1].LanguageOne, LanguageTwo: TempItems[TempItems.count - 1].LanguageTwo, LanguageOneList: TempItems[TempItems.count - 1].WordsLanguageOne, LanguageTwoList: TempItems[TempItems.count - 1].WordsLanguageTwo))
       }
        Openings = TempItems.count
        
        
        applySnapshot(Sections: Items)
        
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .fractionalHeight(1.0))
               let item = NSCollectionLayoutItem(layoutSize: itemSize)

               //
               // Here we are saying make me two columns. Horizontal count: 2.
               // Even though the itemSize say - make me 1:1, the group layout overrides that and makes
               // it stretch to something longer. So group overrides item.

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(350))
               let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
               let spacing = CGFloat(30)
               group.interItemSpacing = .fixed(spacing)

               let section = NSCollectionLayoutSection(group: group)
               section.interGroupSpacing = spacing

               // Another way to add spacing. This is done for the section.
               section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

               let layout = UICollectionViewCompositionalLayout(section: section)
               return layout
        }
    
    
    
    func configureHierarchy() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(LearnCollectionViewCell.self, forCellWithReuseIdentifier: LearnCollectionViewCell.reuseidentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.indexDisplayMode = .automatic
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
        ])
    }
    
   
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ListItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, ListItem) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LearnCollectionViewCell.reuseidentifier,
                for: indexPath) as? LearnCollectionViewCell else { fatalError("Cannot create new cell") }
           
            
            cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.cornerRadius = 20
            cell.layer.backgroundColor = UIColor.systemBlue.cgColor
         
            cell.SetupListCell(Item: ListItem)
            cell.Button.addTarget(self, action: #selector(self.CellButtonTapped), for: .touchUpInside)
            
            let vc = PreQuizViewController()
            vc.SetupListItem(List: ListItem)
            
          
            
            // Return the cell.
            return cell
        }
    }
    
    @objc func CellButtonTapped()
    {
        let vc = PreQuizViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func applySnapshot(Sections: [ListItem])
    {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(Sections)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

