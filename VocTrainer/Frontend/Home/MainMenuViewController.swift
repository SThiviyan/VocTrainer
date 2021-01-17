//
//  MainMenuViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 15.10.20.
//

import UIKit


//just to commit files to github

class MainMenuViewController: UIViewController
{
  
    var collectionView: UICollectionView?
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .systemBackground
        SetupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    func SetupCollectionView()
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
        layout.itemSize = CGSize(width: 150, height: 100)
         
        layout.headerReferenceSize = CGSize(width: view.frame.width * 0.9, height: 450)
        layout.sectionHeadersPinToVisibleBounds = false
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(OtherButtonCells.self, forCellWithReuseIdentifier: OtherButtonCells.reuseidentifier)
        
        collectionView?.register(StatisticsCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StatisticsCell.reuseidentifier)
        
        collectionView?.backgroundColor = .systemGroupedBackground
      
        
        view.addSubview(collectionView ?? UICollectionView(frame: .zero, collectionViewLayout: layout))
        
        collectionView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        
    }
    
    
}


extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherButtonCells.reuseidentifier, for: indexPath)
  
        
        
        let Image = UIImageView()
        Image.translatesAutoresizingMaskIntoConstraints = false
         
        
        let Label = UILabel()
        Label.font = .boldSystemFont(ofSize: 12)
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.numberOfLines = 0
         
        
        cell.contentView.addSubview(Image)
        Image.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        Image.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20).isActive = true
        
        
        cell.contentView.addSubview(Label)
        Label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        Label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20).isActive = true
        Label.trailingAnchor.constraint(equalTo: Image.leadingAnchor, constant: -20).isActive = true
        
        var Num = indexPath.row
        
        switch Num {
        case 0:
            Image.image = UIImage(systemName: "arrowshape.turn.up.right.circle.fill")
            Label.text = "Export to CSV"
            Label.textColor = .white
            cell.contentView.backgroundColor = .systemGreen
            cell.contentView.layer.cornerRadius = 20
            break
        case 1:
            Image.image = UIImage(systemName: "gear")
            Label.text = "Settings"
            Label.textColor = .white
            cell.contentView.backgroundColor = .systemTeal
            cell.contentView.layer.cornerRadius = 20
            break
        case 2:
            Image.image = UIImage(systemName: "minus.circle.fill")
            Label.text = "Reset Mode"
            Label.textColor = .white
            cell.contentView.backgroundColor = .systemRed
            cell.contentView.layer.cornerRadius = 20
            break
        case 3:
            Image.image = UIImage(systemName: "")
            Label.text = "Fillers"
            Label.textColor = .white
            cell.contentView.backgroundColor = .systemPink
            cell.contentView.layer.cornerRadius = 20
            break
        default:
            Image.image = UIImage(systemName: "")
            Label.text = "Error!"
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let Header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StatisticsCell.reuseidentifier, for: indexPath)
        
        
        Header.backgroundColor = .systemTeal
         
        
         return Header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == 0)
        {
            let vc = UIViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.view.backgroundColor = .systemBackground
        }
        else if(indexPath.row == 1)
        {
            
            let vc = SettingsViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        else if(indexPath.row == 2)
        {
            tabBarController?.tabBar.isHidden = true
            
            let ac = UIAlertController(title: "Reset Mode", message: nil, preferredStyle: .actionSheet)
            
            let ActionOne = UIAlertAction(title: "Delete All Lists", style: .destructive, handler: {(action) in
                
                let ac = UIAlertController(title: "Delete", message: "Sure that you want to delete All Lists", preferredStyle: .alert)
                
                
                
                let ActionTwo = UIAlertAction(title: "Delete", style: .destructive, handler: {(action) in
                    self.tabBarController?.tabBar.isHidden = false
                    
                    let Data = DataManager.LoadAll(WordList.self)
                    
                    for item in 0..<Data.count
                    {
                        DataManager.delete(Data[item].name)
                    }
                    
                })
                
                let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:{
                    (action) in
                    self.tabBarController?.tabBar.isHidden = false
                    
                })
                
                ac.addAction(ActionTwo)
                ac.addAction(CancelAction)
                
                self.present(ac, animated: true, completion: nil)
            })
            
            let ActionTwo = UIAlertAction(title: "Delete certain List", style: .destructive, handler: {(action) in
                self.tabBarController?.tabBar.isHidden = false
                let vc = DeleteListsViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            })
            
            let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (action) in
                
                self.tabBarController?.tabBar.isHidden = false
            })
            
            ac.addAction(ActionOne)
            ac.addAction(ActionTwo)
            ac.addAction(CancelAction)
            
            present(ac, animated: true, completion: nil)
            
        }
        else if(indexPath.row == 3)
        {
            
            let vc = UIViewController()
            navigationController?.present(vc, animated: true)
            vc.view.backgroundColor = .systemBackground
        }
    
}



class StatisticsCell: UICollectionViewCell
{
  
    static let reuseidentifier = "StatisticsCell"
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        

    }
}


class OtherButtonCells: UICollectionViewCell
{
    
    static let reuseidentifier = "OtherButtonCells"
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
                
    }
    

   
}
}
