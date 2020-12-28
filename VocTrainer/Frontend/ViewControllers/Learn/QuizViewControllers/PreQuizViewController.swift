//
//  PreQuizViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 19.12.20.
//

import UIKit


class PreQuizViewController: UIViewController
{
    
    var PopupView = UIView()
    
    var ScrollView: UIScrollView =
        {
            var scrollview = UIScrollView()
            scrollview.translatesAutoresizingMaskIntoConstraints = false
            scrollview.alwaysBounceVertical = true
            scrollview.isScrollEnabled = true
            
            return scrollview
        }()
    
    var ScrollViewLength = Int()
    let FirstAssignedView = UIView()
    let ContentView = UIView()

    
    
    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!
    var DataSource: UICollectionViewDiffableDataSource<Section, Int>!
    var Snapshot: NSDiffableDataSourceSnapshot<Section, Int>!
    
    var CurrentListItem: ListItem!
    var CombinedArray = [String]()
    
    var name = String()
    
    var LabelLanguageOne: UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .systemRed
            label.text = "LanguageOne"
            return label
        }()
    
    var LabelLanguageTwo: UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .systemRed
            label.text = "LanguageTwo"
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
        
        ScrollViewLength = Int(view.bounds.midY * 0.65)
        
        title = CurrentListItem.name
        LabelLanguageOne.text = CurrentListItem.LanguageOne
        LabelLanguageTwo.text = CurrentListItem.LanguageTwo
    
       
        SetupHierachy()
        SetupHierarchyofLabels()
        SetupEditBarButton()
        ConfigureCollectionViewHierarchy()
        SetupHierarchyofButton()
        
        ContentView.sizeToFit()
        
        ConfigureDataSource()
    }
    
    func SetupHierachy()
    {
            
        view.addSubview(ScrollView)
        
        ScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        ScrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        ScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        ScrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        

        FirstAssignedView.translatesAutoresizingMaskIntoConstraints = false
            
        ScrollView.addSubview(FirstAssignedView)
        
        FirstAssignedView.leadingAnchor.constraint(equalTo: ScrollView.leadingAnchor).isActive = true
        FirstAssignedView.topAnchor.constraint(equalTo: ScrollView.topAnchor).isActive = true
        FirstAssignedView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        FirstAssignedView.heightAnchor.constraint(equalToConstant: CGFloat(ScrollViewLength)).isActive = true
        
       
        ContentView.translatesAutoresizingMaskIntoConstraints = false
        
        ScrollView.addSubview(ContentView)
        
        ContentView.leadingAnchor.constraint(equalTo: ScrollView.leadingAnchor).isActive = true
        ContentView.topAnchor.constraint(equalTo: FirstAssignedView.bottomAnchor).isActive = true
        ContentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        ContentView.heightAnchor.constraint(equalToConstant: CGFloat(ScrollViewLength)).isActive = true
        ContentView.bottomAnchor.constraint(equalTo: ScrollView.bottomAnchor).isActive = true
        
    }
    
    func SetupHierarchyofLabels()
    {
        ContentView.addSubview(LabelLanguageOne)
        LabelLanguageOne.topAnchor.constraint(equalTo: FirstAssignedView.topAnchor, constant: 20).isActive = true
        LabelLanguageOne.leadingAnchor.constraint(equalTo: ScrollView.leadingAnchor, constant: 20).isActive = true
        
        
        ContentView.addSubview(LabelLanguageTwo)
        LabelLanguageTwo.topAnchor.constraint(equalTo: LabelLanguageOne.bottomAnchor, constant: 10).isActive = true
        LabelLanguageTwo.leadingAnchor.constraint(equalTo: LabelLanguageOne.leadingAnchor).isActive = true
        
      
       
        
    }
    
    
    func SetupHierarchyofButton()
    {
       
        ContentView.addSubview(Button)
        
        Button.centerXAnchor.constraint(equalTo: ContentView.centerXAnchor).isActive = true
        Button.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        Button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        Button.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
}



extension PreQuizViewController
{
    //Setup Bar Button
    func SetupEditBarButton()
    {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let EditItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(BarButtonTapped))
        
        navigationItem.rightBarButtonItem = EditItem
    }
    
    @objc func BarButtonTapped()
    {
        let Alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive)
        { (action) in
            let DeleteAlert = UIAlertController(title: nil, message: "Do you really want to delete this List?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "delete", style: .destructive)
            { (action) in
                
                let nameOfList = self.CurrentListItem.name
                DataManager.delete(nameOfList)
                
                let vc = LearnMenuViewController()

                for item in 0..<vc.Items.count
                {
                    if(nameOfList == vc.Items[item].name)
                    {
                        vc.Items.remove(at: item)
                    }
                }
                
                self.navigationController?.popToRootViewController(animated: true)
                
            }
            
            let DismissAction = UIAlertAction(title: "cancel", style: .cancel)
            { (action) in
                
            }
            
            DeleteAlert.addAction(deleteAction)
            DeleteAlert.addAction(DismissAction)
            
            self.present(DeleteAlert, animated: true, completion: nil)
            
        }
        
        let EditAction = UIAlertAction(title: "Edit Wordlist", style: .default)
        { (action) in
            
        }
        
        let EditLanguagesAction = UIAlertAction(title: "Edit Languages", style: .default)
        { (action) in
            self.SetupPopUpView()
        }
        
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        { (action) in
            
        }
        
        
        Alert.addAction(EditAction)
        Alert.addAction(EditLanguagesAction)
        Alert.addAction(DeleteAction)
        Alert.addAction(CancelAction)
        
        Alert.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        self.present(Alert, animated: true, completion: nil)
    }
    
}


extension PreQuizViewController
{
    //setup dataSource for UIViewController
    
    public func SetupListItem(List: ListItem)
    {
        CurrentListItem = ListItem(name: List.name, TimeAdded: List.TimeAdded, LanguageOne: List.LanguageOne, LanguageTwo: List.LanguageTwo, LanguageOneList: List.LanguageOneList, LanguageTwoList: List.LanguageTwoList)
        
     
    
        
        CombinedArray = List.LanguageTwoList
       
        var Runs = 0

        for item in 0...CombinedArray.underestimatedCount * 2 {
            if(item < CombinedArray.underestimatedCount)
            {
             if(item % 2 == 0) {
                CombinedArray.insert(List.LanguageOneList[Runs], at: item)

                Runs += 1
             }
            }
        }
        
       // print(CombinedArray)
    }
    
    
}



extension PreQuizViewController
{
    //Everything about UICollectionView
    
    func ConfigureCollectionViewHierarchy()
    {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: CreateLayout())
        collectionView.dataSource = DataSource
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseidentifier)
        collectionView.backgroundColor = .systemBackground
        
        ContentView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: LabelLanguageTwo.bottomAnchor, constant: 10).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: ContentView.centerXAnchor).isActive = true
        //collectionView.bottomAnchor.constraint(equalTo: Button.topAnchor, constant: -10).isActive = true
        collectionView.widthAnchor.constraint(equalTo: ContentView.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.bounds.midY * 0.80).isActive = true
        
    }
    
    func ConfigureDataSource()
    {
        DataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView){
            (collectionView: UICollectionView, indexPath: IndexPath, Num) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CustomCell.reuseidentifier,
                for: indexPath) as? CustomCell else { fatalError("Cannot create new cell") }
           
            cell.contentView.backgroundColor = .systemBackground
            cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
            cell.layer.borderWidth = 1
            
            
            if(Num < self.CombinedArray.underestimatedCount)
            {
                cell.TextField.text = self.CombinedArray[Num]
            }
        
            return cell
        }
        
        var Snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        Snapshot.appendSections([.main])
        Snapshot.appendItems(Array(0..<CurrentListItem.LanguageOneList.count + CurrentListItem.LanguageTwoList.count))
        DataSource.apply(Snapshot)
    }
    
    func CreateLayout() -> UICollectionViewLayout
    {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let layout = UICollectionViewCompositionalLayout(section: section)
    
        return layout
    }
    
    
}


extension PreQuizViewController
{
    //Pop Up View for language Change
    
    func SetupPopUpView()
    {
        view.addSubview(PopupView)
        
        
        PopupView.translatesAutoresizingMaskIntoConstraints = false
        
        PopupView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PopupView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        PopupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        PopupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        PopupView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        PopupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        PopupView.layer.cornerRadius = 20
        
        PopupView.bringSubviewToFront(view)
        
        
        PopupView.backgroundColor = .systemRed
    
        
    }
    
    
    
}
