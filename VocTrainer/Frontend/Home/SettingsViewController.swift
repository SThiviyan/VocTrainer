//
//  SettingsViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 13.01.21.
//

import UIKit

class SettingsViewController: UIViewController {

    
    let tableview: UITableView =
        {
            let tableview = UITableView(frame: .zero)
            tableview.translatesAutoresizingMaskIntoConstraints = false
            
            return tableview
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Settings"
        
        SetupTableView()
    }
    

    func SetupTableView()
    {
        tableview.dataSource = self
        tableview.delegate = self
        
        
        view.addSubview(tableview)
        
        tableview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableview.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }


}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
   
    

}
