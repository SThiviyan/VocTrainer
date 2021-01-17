//
//  DeleteListsViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 15.01.21.
//

import UIKit

class DeleteListsViewController: UIViewController {

    
    var TableView: UITableView =
        {
            let TableView = UITableView(frame: .zero, style: .plain)
            TableView.translatesAutoresizingMaskIntoConstraints = false
            TableView.allowsMultipleSelection = false
            
            return TableView
        }()
    
    var Data = [WordList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Delete Lists"
        view.backgroundColor = .systemBackground
        
        SetupUsableData()
        SetupTableView()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    func SetupTableView()
    {
        
        
        view.addSubview(TableView)
        
        TableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        TableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        TableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        TableView.delegate = self
        TableView.dataSource = self
        
        
    }
    
    
    
    func SetupUsableData()
    {
        
        Data = DataManager.LoadAll(WordList.self)
        
    }
       

}


extension DeleteListsViewController: UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
}


extension DeleteListsViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DeleteListCell()
        
        cell.SetupWith(Name: Data[indexPath.row].name, LanguageOne: Data[indexPath.row].LanguageOne, LanguageTwo: Data[indexPath.row].LanguageTwo)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.count
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {

                    // remove the item from the data model
                    //animals.remove(at: indexPath.row)

                    // delete the table view row
            
            let FileToDelete = Data[indexPath.row].name
            
            Data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()

            DataManager.delete(FileToDelete)
            
        }
        
        
    }

    
}



class DeleteListCell: UITableViewCell
{
    
    let NameLabel: UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
    
    let LanguageOneLabel: UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    let LanguageTwoLabel: UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .systemBackground
        SetupLabels()

    }
    
    
    func SetupLabels(){
        
        
        let LabelForName = UILabel()
        LabelForName.font = .boldSystemFont(ofSize: 15)
        LabelForName.text = "Name:"
        LabelForName.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(LabelForName)
        LabelForName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        LabelForName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        contentView.addSubview(NameLabel)
        NameLabel.leadingAnchor.constraint(equalTo: LabelForName.leadingAnchor).isActive = true
        NameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
     
        
        
        let LabelForLanguages = UILabel()
        LabelForLanguages.font = .boldSystemFont(ofSize: 15)
        LabelForLanguages.text = "Languages:"
        LabelForLanguages.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(LabelForLanguages)
        LabelForLanguages.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        LabelForLanguages.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        contentView.addSubview(LanguageOneLabel)
        LanguageOneLabel.trailingAnchor.constraint(equalTo: LabelForLanguages.trailingAnchor).isActive = true
        LanguageOneLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.addSubview(LanguageTwoLabel)
        LanguageTwoLabel.trailingAnchor.constraint(equalTo: LabelForLanguages.trailingAnchor).isActive = true
        LanguageTwoLabel.topAnchor.constraint(equalTo: LanguageOneLabel.bottomAnchor, constant: 10).isActive = true
        
      
    }
    
    func SetupWith(Name: String, LanguageOne: String, LanguageTwo: String)
    {
        NameLabel.text = Name
        LanguageOneLabel.text = LanguageOne
        LanguageTwoLabel.text = LanguageTwo
        
    }
    
}
