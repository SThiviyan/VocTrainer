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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
        
     
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
        SegmentControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30).isActive = true
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
            self.SetupEditLanguagesView()
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
    
    
    public func OverrideLanguagePair(FirstL: String, SecondL: String)
    {
        
        print("Override initiated")
                
        print(FirstL)
        print(SecondL)
        
        
        LabelLanguageOne.text = FirstL
        LabelLanguageTwo.text = SecondL
        
        
        
        /*
        DataManager.delete(Name)
        
        let WordListToSave = WordList(name: CurrentListItem.name, TimeAdded: CurrentListItem.TimeAdded, LanguageOne: FirstL, LanguageTwo: SecondL, WordsLanguageOne: CurrentListItem.LanguageOneList, WordsLanguageTwo: CurrentListItem.LanguageTwoList)
        
        
        WordListToSave.SaveItem()
        */
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
        collectionView.heightAnchor.constraint(equalToConstant: CGFloat(ScrollViewLength) * 1.2).isActive = true
        
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
    
    
    func SetupEditLanguagesView()
    {
        let vc = EditLanguagesViewController()
        present(vc, animated: true, completion: nil)
    }
   
    
    
    
}



class EditLanguagesViewController: UIViewController
{

    var NewLanguageOne: String!
    var NewLanguageTwo: String!
    
    let PickerView: UIPickerView =
        {
            let picker = UIPickerView()
            picker.translatesAutoresizingMaskIntoConstraints = false
            
            return picker
        }()
    
    
    let ListOfLanguages = ["English","Spanish","French","German","Portuguese","Dutch","Japanese","Italian"]
    
    let Button = UIButton()
    let Label = UILabel()
    let SaveChangesButton = CustomButton()
    let ErrorLabel = UILabel()



    override func viewDidLoad() {
        SetupView()
    }

    
    func SetupView()
    {
        
        view.backgroundColor = .systemBackground
        
        
       
        
        Label.font = .boldSystemFont(ofSize: 30)
        Label.text = "Change Language Pair"
        Label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(Label)
        
        Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        Label.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
    
        

        
        
        //Button.setTitle("Dismiss", for: .normal)
        Button.setImage(UIImage(systemName: "xmark"), for: .normal)
        Button.tintColor = .systemGray
        
        
        Button.addTarget(self, action: #selector(CancelButtonTapped), for: .touchUpInside)
        
        view.addSubview(Button)
        
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        Button.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        
        PickerView.delegate = self
        PickerView.dataSource = self
        view.addSubview(PickerView)
        
        PickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
       
        SaveChangesButton.setTitle("Save Changes", for: .normal)
        
        view.addSubview(SaveChangesButton)
        
        SaveChangesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        SaveChangesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SaveChangesButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        SaveChangesButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        SaveChangesButton.addTarget(self, action: #selector(SaveButtonTapped), for: .touchUpInside)
    }
   
    
    @objc func CancelButtonTapped()
    {
        dismiss(animated: true, completion: nil)
   
    }
    
    
    @objc func SaveButtonTapped()
    {
        if(NewLanguageOne != NewLanguageTwo)
        {
            ErrorLabel.isHidden = true
            
            let AlertController = UIAlertController(title: "Save Changes?", message: "", preferredStyle: .alert)
        
            let alert = UIAlertAction(title: "Save", style: .default)
            {(action) in
            
             self.dismiss(animated: true, completion: nil)
             let vc = PreQuizViewController()
                vc.OverrideLanguagePair(FirstL: self.NewLanguageOne, SecondL: self.NewLanguageTwo)

            }
        
            let alert2 = UIAlertAction(title: "cancel", style: .cancel)
           {(action) in
            
            }
           AlertController.addAction(alert)
           AlertController.addAction(alert2)
        
        
        self.present(AlertController, animated: true, completion: nil)
            
        }
        
        
        else
        {
            ErrorLabel.isHidden = false
            ErrorLabel.text = "Please choose two different Languages"
            ErrorLabel.font = .boldSystemFont(ofSize: 14)
            ErrorLabel.textColor = .systemRed
            ErrorLabel.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(ErrorLabel)
            
            ErrorLabel.topAnchor.constraint(equalTo: SaveChangesButton.bottomAnchor, constant: 10).isActive = true
            ErrorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
        }
    }
    
}


extension EditLanguagesViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
   
    func numberOfComponents(in PickerView: UIPickerView) -> Int{
        return 2
    }
    
    func pickerView(_ PickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int
    {
        return ListOfLanguages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           if component == 0 {
               return ListOfLanguages[row]
           }else {
               return ListOfLanguages[row]
           }
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NewLanguageOne = ListOfLanguages[pickerView.selectedRow(inComponent: 0)]
        NewLanguageTwo = ListOfLanguages[pickerView.selectedRow(inComponent: 1)]
    }
    
    
   
}
