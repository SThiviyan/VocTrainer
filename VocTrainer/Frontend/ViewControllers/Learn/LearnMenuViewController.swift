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
 
     let AddWordsButton: CustomButton =
        {
            let Button = CustomButton()
            Button.setTitle("Add Words", for: .normal)
            return Button
        }()
    
    enum Section {
        case main
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        title = "Learn"
        view.backgroundColor = .systemBackground
                        
        let addBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(ButtonTapped))
        navigationItem.rightBarButtonItem = addBtn
        
        
        configureHierarchy()
        configureDataSource()
    }
  
    
    @objc func ButtonTapped()
    {
        let vc = AddWordsViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        
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
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
        ])
    }
    
   
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LearnCollectionViewCell.reuseidentifier,
                for: indexPath) as? LearnCollectionViewCell else { fatalError("Cannot create new cell") }
            
            if(DataManager.GetTotalNum(WordList.self) == 0)
            {
                cell.contentView.removeFromSuperview()
                cell.contentView.addSubview(cell.EmptyLabel)
                cell.EmptyLabel.textColor = .systemGray
                cell.contentView.backgroundColor = .systemBlue
            }
            else
            {
                cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
                cell.layer.borderWidth = 2
                cell.layer.borderColor = UIColor.white.cgColor
                cell.layer.cornerRadius = 20
                cell.layer.backgroundColor = UIColor.systemBlue.cgColor
                cell.EmptyLabel.textColor = .systemBlue
                
                cell.Button.addTarget(self, action: #selector(self.CellButtonTapped), for: .touchUpInside)
            }
    
            // Return the cell.
            return cell
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        var CellNum = DataManager.GetTotalNum(WordList.self)
        
        if(CellNum == 0)
        {
            CellNum = 1
        }
        
        
        snapshot.appendItems(Array(0..<DataManager.GetTotalNum(WordList.self)))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc func CellButtonTapped()
    {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemRed
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



