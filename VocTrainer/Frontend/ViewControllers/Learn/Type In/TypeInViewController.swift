//
//  TypeInViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 24.10.20.
//

import UIKit

//just to commit files to github

class TypeInViewController: UIViewController
{
    enum Section {
        case main
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    var texts = [Int:String]()
    
    var NumRows = 30
    
    
    let Continue: CustomButton =
        {
            let ContinueButton = CustomButton()
            ContinueButton.setTitle("Continue", for: .normal)
            ContinueButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
            ContinueButton.translatesAutoresizingMaskIntoConstraints = false
            
            return ContinueButton
        }()
    
    let LabelLanguageOne: UILabel =
        {
            let Label = UILabel()
            Label.font = .boldSystemFont(ofSize: 17)
            Label.translatesAutoresizingMaskIntoConstraints = false
            
            return Label
        }()
   
    let LabelLanguagetwo: UILabel =
        {
            let Label = UILabel()
            Label.font = .boldSystemFont(ofSize: 17)
            Label.translatesAutoresizingMaskIntoConstraints = false
            
            return Label
        }()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "WordList"
        
        Continue.addTarget(self, action: #selector(ContinueButtonTapped), for: .touchUpInside)
        view.addSubview(Continue)
        
        view.addSubview(LabelLanguageOne)
        view.addSubview(LabelLanguagetwo)
               
        configureHierarchy()
        configureDataSource()
       
        
        initializeHideKeyboard()
        
        setLayout()
    }
    
    @objc func ContinueButtonTapped()
    {
        let vc = NamingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setLayout()
    {
        
        
        Continue.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Continue.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120).isActive = true
        Continue.widthAnchor.constraint(equalToConstant: 350).isActive = true
        Continue.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
      
        
        LabelLanguageOne.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        LabelLanguageOne.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        LabelLanguagetwo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        LabelLanguagetwo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        
       
    }
    
    
    
    
    func LoadWordsIntoCPP()
    {
         
    }
    

}


extension TypeInViewController
{
    func createLayout() -> UICollectionViewLayout {
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
    
extension TypeInViewController
{
    func configureHierarchy() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseidentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.indexDisplayMode = .automatic
    
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: LabelLanguageOne.bottomAnchor, constant: 10),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: Continue.topAnchor, constant: -20),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
        ])
    }
    
   
   
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in

            // Get a cell of the desired kind.
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CustomCell.reuseidentifier,
                for: indexPath) as? CustomCell else { fatalError("Cannot create new cell") }
            
          
            //to get Textfield number get identifier
            if(identifier % 2 == 0)
            {
                cell.TextField.placeholder = "\(self.LabelLanguageOne.text ?? "LanguageOne") Word"
            }
            else
            {
                cell.TextField.placeholder = "\(self.LabelLanguagetwo.text ?? "LanguageTwo") Word"
            }
      
            
            cell.contentView.backgroundColor = .systemBackground
            cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
            cell.layer.borderWidth = 1
            cell.TextField.textAlignment = .center
            cell.TextField.font = UIFont.preferredFont(forTextStyle: .body)
            cell.TextField.delegate = self
            cell.TextField.tag = indexPath.row
            if let previousText = self.texts[indexPath.row] {
                 cell.TextField.text = previousText
               }
               else {
                 cell.TextField.text = ""
               }
            cell.isSelected = true
           
            // Return the cell.
            return cell
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<NumRows))
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
    
    
}


extension TypeInViewController: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField) {
        texts[textField.tag] = textField.text
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
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
