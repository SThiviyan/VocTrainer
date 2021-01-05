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
            label.text = "LanguageOne"
            label.font = .boldSystemFont(ofSize: 17)
            return label
        }()
    
    var LabelLanguageTwo: UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "LanguageTwo"
            label.font = .boldSystemFont(ofSize: 17)
            return label
        }()
    
    
    let Button: CustomButton =
        {
            let Button = CustomButton()
            Button.setTitle("Start Quiz", for: .normal)
            
            return Button
        }()
    
    var SegmentControl: UISegmentedControl =
        {
            let view = UISegmentedControl()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
  
    let errorLabel: UILabel =
    {
            let label = UILabel()
            label.text = "Please select an order"
            label.textColor = .systemRed
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .boldSystemFont(ofSize: 14)
            label.numberOfLines = 0
            return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        ScrollViewLength += Int(view.bounds.midY * 0.65)
        
        title = CurrentListItem.name
        LabelLanguageOne.text = CurrentListItem.LanguageOne
        LabelLanguageTwo.text = CurrentListItem.LanguageTwo
    
       
        SetupHierachy()
        SetupHierarchyofLabels()
        SetupEditBarButton()
        ConfigureCollectionViewHierarchy()
        SetupHierarchyofButton()
        
        
        ConfigureDataSource()
        
        SetupPopUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
        
        PopupView.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        PopupView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75).isActive = true
        
        errorLabel.isHidden = true
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
        LabelLanguageTwo.topAnchor.constraint(equalTo: FirstAssignedView.topAnchor, constant: 20).isActive = true
        LabelLanguageTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
      
       
        
    }
    
    
    func SetupHierarchyofButton()
    {
       
        ContentView.addSubview(SegmentControl)
        SegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SegmentControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        SegmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        SegmentControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075).isActive = true
        
        let FirstSegmentString = "\(LabelLanguageOne.text ?? "One") to \(LabelLanguageTwo.text ?? "Two")"
        let SecondSegmentString = "\(LabelLanguageTwo.text ?? "Two") to \(LabelLanguageOne.text ?? "One")"
        
        SegmentControl.insertSegment(withTitle: FirstSegmentString, at: 0, animated: true)
        SegmentControl.insertSegment(withTitle: SecondSegmentString, at: 1, animated: true)
        
        
        
        ContentView.addSubview(Button)
        
        Button.centerXAnchor.constraint(equalTo: ContentView.centerXAnchor).isActive = true
        Button.topAnchor.constraint(equalTo: SegmentControl.bottomAnchor, constant: 30).isActive = true
        Button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        Button.widthAnchor.constraint(equalToConstant: 350).isActive = true
        
        Button.addTarget(self, action: #selector(StartButtonTapped), for: .touchUpInside)
        
        
        ContentView.addSubview(errorLabel)
    
        
        errorLabel.centerXAnchor.constraint(equalTo: FirstAssignedView.centerXAnchor).isActive = true
        errorLabel.topAnchor.constraint(equalTo: Button.bottomAnchor, constant: 10).isActive = true
          
    }
    
}

extension PreQuizViewController
{
    @objc func StartButtonTapped()
    {
        if(SegmentControl.selectedSegmentIndex == -1)
        {
            errorLabel.isHidden = false
        }
        else
        {
          let vc = QuizViewController()
            
            errorLabel.isHidden = true
            
            if(SegmentControl.selectedSegmentIndex == 0)
            {
                vc.LanguageOneWords = CurrentListItem.LanguageOneList
                vc.LanguageTwoWords = CurrentListItem.LanguageTwoList
            }
            else
            {
                vc.LanguageOneWords = CurrentListItem.LanguageTwoList
                vc.LanguageTwoWords = CurrentListItem.LanguageOneList
                
            }
        
          tabBarController?.tabBar.isHidden = true
          navigationController?.pushViewController(vc, animated: true)
        }
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
            
            self.tabBarController?.tabBar.isHidden = true
            self.LetPopUpViewAppear()
            
            //let vc = UIViewController()
            //vc.view.backgroundColor = .systemBackground
            //self.navigationController?.present(vc, animated: true, completion: nil)
            
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
            
            cell.TextField.isEnabled = false
        
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
        PopupView.isHidden = false

        view.addSubview(PopupView)

        PopupView.translatesAutoresizingMaskIntoConstraints = false
        PopupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        PopupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
       
        PopupView.layer.cornerRadius = 20
        PopupView.layer.borderColor = UIColor.white.cgColor
        PopupView.layer.borderWidth = 2.5
        
        
        PopupView.backgroundColor = .systemBackground
        
        let Button = UIButton()
        
        
        //Button.setTitle("Dismiss", for: .normal)
        Button.setImage(UIImage(systemName: "xmark"), for: .normal)
        Button.tintColor = .systemGray
        
        
        Button.addTarget(self, action: #selector(PopUpViewCancelButtonTapped), for: .touchUpInside)
        
        PopupView.addSubview(Button)
        
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.trailingAnchor.constraint(equalTo: PopupView.trailingAnchor, constant: -20).isActive = true
        Button.topAnchor.constraint(equalTo: PopupView.topAnchor, constant: 20).isActive = true
        
        
    }
    
    func LetPopUpViewAppear()
    {
    
        PopupView.isHidden = false

        PopupView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
       
        
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.view.layoutIfNeeded()
                       },
                       completion: nil
                        )
          
    
        
       
    }
    

    
    @objc func PopUpViewCancelButtonTapped()
    {
        PopupView.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations:
                        {
                            self.view.layoutIfNeeded()
                        },
                       completion: nil)
        
        PopupView.isHidden = true
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
}


