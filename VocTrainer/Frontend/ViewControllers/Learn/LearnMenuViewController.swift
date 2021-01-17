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
    
    
    let EmptyLabel: UILabel =
        {
            let EmptyLabel = UILabel()
            EmptyLabel.translatesAutoresizingMaskIntoConstraints = false
            EmptyLabel.textColor = .systemGray4
            EmptyLabel.text = "Add WordLists to Study"
            
            
            return EmptyLabel
        }()
    
    
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
    var BlackListNums = [Int]()
    
    var BlackList = [ListItem]()
   
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
        SetupIsEmptyLabel()
       
        //loaddata()

        
        if(traitCollection.userInterfaceStyle == .dark)
        {
            collectionView.backgroundColor = .black
        }
        else
        {
            collectionView.backgroundColor = .systemGroupedBackground
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AnimateCellsAppearance()
        
        
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        
        let TempData = DataManager.LoadAll(WordList.self)
            .sorted(by: {
            $0.TimeAdded < $1.TimeAdded
        })
        
        if(DataManager.GetTotalNum(WordList.self) == 0)
        {
            EmptyLabel.isHidden = false
        }
        else if(DataManager.GetTotalNum(WordList.self) > 0)
        {
            EmptyLabel.isHidden = true
        }
        
        var compareList = [ListItem]()
        
        for Num in 0..<TempData.count {
            compareList.append(ListItem(name: TempData[Num].name, TimeAdded: TempData[Num].TimeAdded, LanguageOne: TempData[Num].LanguageOne, LanguageTwo: TempData[Num].LanguageTwo, LanguageOneList: TempData[Num].WordsLanguageOne, LanguageTwoList: TempData[Num].WordsLanguageTwo))
        }
        
        compareList.append(contentsOf: Items)
        
        Items = Array(Set(compareList))
        
        Items = Items.sorted(by: {
            $0.TimeAdded < $1.TimeAdded
        })
        
        
        if(Items.count > TempData.count)
        {
            
            var CheckInts = [Int]()
           
            if(TempData.count != 0)
            {
              for item in 0..<Items.count
              {
                CheckInts.append(0)
                  for Num in 0..<TempData.count {
                     
                    if(Items[item].name == TempData[Num].name)
                    {
                        CheckInts[item] += 1
                    }
                    
                  }
                
              }
                
                for item in 0..<Items.count {
                    if(CheckInts[item] == 0)
                    {
                        Items.remove(at: item)
                    }
                }
                
                
            }
            else
            {
                Items.removeAll()
            }
            
        }
      
     
        applySnapshot(Sections: Items)

        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    
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
        navigationItem.searchController?.searchBar.returnKeyType = .search
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
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
        if(searchcontroller.searchBar.text == "")
        {
            applySnapshot(Sections: Items)
        }
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
               
        alert.popoverPresentationController?.sourceView = button
               
        self.present(alert, animated: true) {
             // The alert was presented
        }
    }
    
    
    
    func SetupBarButton()
    {
        let SortBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .done, target: self, action: #selector(BarButtonPressed))
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
        
        let SortByDate = UIAlertAction(title: "Date Created", style: .default)
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
        
        Alert.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
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
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        

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
            cell.Button.tag = indexPath.row
            
            let vc = PreQuizViewController()
            vc.SetupListItem(List: ListItem)
            
          
            
            // Return the cell.
            return cell
        }
    }
    
    @objc func CellButtonTapped(sender: UIButton)
    {
        let vc = PreQuizViewController()
        if(searchcontroller.searchBar.text != "")
        {
            vc.SetupListItem(List: filteredListItems[sender.tag])
        }
        else
        {
            vc.SetupListItem(List: Items[sender.tag])
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func applySnapshot(Sections: [ListItem])
    {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(Sections)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    func SetupIsEmptyLabel()
    {
      
        view.addSubview(EmptyLabel)
        EmptyLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        EmptyLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        
        EmptyLabel.isHidden = true
    }
    
    
}



extension LearnMenuViewController: UICollectionViewDelegate
{
    func AnimateCellsAppearance()
    {
       
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        UIView.animate(withDuration: 0.2)
        {
            self.view.layoutIfNeeded()
        }
               
    }
        
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        if(traitCollection.userInterfaceStyle == .dark)
        {
            collectionView.backgroundColor = .black
        }
        else
        {
            collectionView.backgroundColor = .systemGroupedBackground
        }
        
        
    }
    

           
        
    
    
}
