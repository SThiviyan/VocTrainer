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
    
    let EmptyLabel: UILabel =
        {
            let EmptyLabel = UILabel()
            EmptyLabel.translatesAutoresizingMaskIntoConstraints = false
            EmptyLabel.textColor = .systemGray4
            EmptyLabel.text = "Create Wordlists to see all your Words here"
            EmptyLabel.numberOfLines = 0
            
            
            return EmptyLabel
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
        SetupIsEmptyLabel()
        //initializeHideKeyboard()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        
        let TempItems = DataManager.LoadAll(WordList.self)
        
        
        if(DataManager.GetTotalNum(WordList.self) == 0)
        {
            EmptyLabel.isHidden = false
        }
        else if(DataManager.GetTotalNum(WordList.self) > 0)
        {
            EmptyLabel.isHidden = true
        }
        
        
        for Num in 0..<TempItems.count {
            ListItems.append(ListItem(name: TempItems[Num].name, TimeAdded: TempItems[Num].TimeAdded, LanguageOne: TempItems[Num].LanguageOne, LanguageTwo: TempItems[Num].LanguageTwo, LanguageOneList: TempItems[Num].WordsLanguageOne, LanguageTwoList: TempItems[Num].WordsLanguageTwo))
        }
        
        
        SetupLanguagesArray()
        
        searchcontroller.searchBar.scopeButtonTitles = AllLanguages
        
        AddWordstoTableView()

        TableView.reloadData()
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
       
    func SetupIsEmptyLabel()
    {
      
        view.addSubview(EmptyLabel)
        EmptyLabel.centerXAnchor.constraint(equalTo: TableView.centerXAnchor).isActive = true
        EmptyLabel.centerYAnchor.constraint(equalTo: TableView.centerYAnchor).isActive = true
        
        EmptyLabel.isHidden = true
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
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = WordViewController()
        //vc.navigationBar.prefersLargeTitles = true
        vc.SetupTitle(titleOfVC: Words[indexPath.row], Language: AllLanguages[searchcontroller.searchBar.selectedScopeButtonIndex])
        
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

struct TranslationList: Hashable
{
    var Word: String
    var FromLanguage: String
}

class WordViewController: UIViewController
{
    let TitleLabel: UILabel =
        {
           let label = UILabel()
            label.font = .boldSystemFont(ofSize: 37)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            
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
    
    
    enum Section
    {
        case Main
    }
    
    var collectionview: UICollectionView!
    var diffableDataSource: UICollectionViewDiffableDataSource<Section, TranslationList>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, TranslationList>!
    
    
    var List: [String: String]!
    var Items = [TranslationList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
       
        //title = "Your Word:"
        SetupBarButton()
        
    }
    
    
    func SetupTitle(titleOfVC: String, Language: String)
    {
        view.addSubview(TitleLabel)
        TitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        TitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        TitleLabel.text = titleOfVC
        
        
        SetupOtherLabels()
        
        List = GetMatchingWords(FromLanguage: Language, Word: titleOfVC)
        
        
        for (key, value) in List
        {
            Items.append(TranslationList(Word: key, FromLanguage: value))
        }
        
        ConfigureCollectionView()
        ConfigureDataSource()
        
        
        
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
    
    
    
    func GetMatchingWords(FromLanguage: String, Word: String) -> [String: String]
    {
        /*
          Dictionary for Array:
          Word: Language
          Word->From Search through list
          Language->From Corresponding List
        */
        
        var Matches = [String: String]()
         
        let Data = DataManager.LoadAll(WordList.self)
        //var FilteredData = [WordList]()
        
        for item in 0..<Data.count
        {
            if(Data[item].LanguageOne == FromLanguage)
            {
                for i in 0..<Data[item].WordsLanguageOne.count {
                    if(Word.lowercased() == Data[item].WordsLanguageOne[i].lowercased())
                    {
                        Matches[Data[item].WordsLanguageTwo[i]] = Data[item].LanguageTwo
                        
                    }
                }
            }
            else if(Data[item].LanguageTwo == FromLanguage)
            {
                for i in 0..<Data[item].WordsLanguageTwo.count {
                    if(Word.lowercased() == Data[item].WordsLanguageTwo[i].lowercased())
                    {
                        Matches[Data[item].WordsLanguageOne[i]] = Data[item].LanguageOne
                    }
                }
            }
        }
        
        
        return Matches
    }
    

    func SetupBarButton()
    {
        let Button = UIButton()
        Button.setImage(UIImage(systemName: "xmark"), for: .normal)
        Button.tintColor = .systemGray
        Button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(Button)
        
        print("Pressed")
        
        Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        Button.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        
        
        Button.addTarget(self, action: #selector(DismissButtonTapped), for: .touchUpInside)
    }
    
    @objc func DismissButtonTapped()
    {
        dismiss(animated: true, completion: nil)
    }
}

extension WordViewController
{
    
    func ConfigureCollectionViewLayout() -> UICollectionViewLayout
    {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(70))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let spacing = CGFloat(20)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10)
        section.interGroupSpacing = spacing
      

        let layout = UICollectionViewCompositionalLayout(section: section)
    
        return layout
    }
    
    func ConfigureCollectionView()
    {
        collectionview = UICollectionView(frame: .zero, collectionViewLayout: ConfigureCollectionViewLayout())
        collectionview.dataSource = diffableDataSource
        collectionview.register(TranslationCell.self, forCellWithReuseIdentifier: TranslationCell.reuseidentifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        
        if(self.traitCollection.userInterfaceStyle == .dark)
        {
           collectionview.backgroundColor = .black
        }
        else
        {
            collectionview.backgroundColor = .systemGroupedBackground
        }
        view.addSubview(collectionview)
        
        collectionview.topAnchor.constraint(equalTo: AnotherLabel.bottomAnchor, constant: 20).isActive = true
        collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    func ConfigureDataSource()
    {
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionview)
        {
        (collectionView: UICollectionView, indexPath: IndexPath, List) -> UICollectionViewCell? in
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TranslationCell.reuseidentifier,
            for: indexPath) as? TranslationCell else { fatalError("Cannot create new cell") }
       
        cell.contentView.backgroundColor = .systemBackground
        cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        cell.layer.borderWidth = 0
        cell.InitWithList(Item: List)
     
        return cell
    }
    
    var Snapshot = NSDiffableDataSourceSnapshot<Section, TranslationList>()
    Snapshot.appendSections([.Main])
        
    //let Item = TranslationList(Word: "Der Senat", FromLanguage: "German")
    Snapshot.appendItems(Items)
    diffableDataSource.apply(Snapshot)
    }
}


extension WordViewController
{
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        if(self.traitCollection.userInterfaceStyle == .dark)
        {
           collectionview.backgroundColor = .black
        }
        else
        {
            collectionview.backgroundColor = .systemGroupedBackground
        }
        
    }
    
}
        
        

class TranslationCell: UICollectionViewCell
{
    static let reuseidentifier = "TranslationCell"
  
    
    let TranslationLabel: UILabel =
        {
            let Label = UILabel()
            Label.translatesAutoresizingMaskIntoConstraints = false
            Label.font = .boldSystemFont(ofSize: 16)
            
            return Label
        }()
    
    let WordLabel: UILabel =
        {
            let Label = UILabel()
            Label.translatesAutoresizingMaskIntoConstraints = false
            Label.font = .boldSystemFont(ofSize: 16)
            
            return Label
        }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10
    }
    
    func InitWithList(Item: TranslationList)
    {
        contentView.addSubview(TranslationLabel)
        TranslationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        TranslationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        TranslationLabel.text = "\(Item.FromLanguage):"
        
        contentView.addSubview(WordLabel)
        WordLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        WordLabel.leadingAnchor.constraint(equalTo: TranslationLabel.trailingAnchor, constant: 10).isActive = true
        WordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        WordLabel.text = Item.Word
        
    }
    
    
   
    
}
    
    
    
    
    
    

