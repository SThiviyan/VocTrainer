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
    
    let ListButton: CustomButton =
        {
            let Button = CustomButton()
            Button.backgroundColor = .systemBlue
            Button.layer.cornerRadius = 20
            return Button
        }()

    
   
    let scrollview: CustomScrollView =
        {
            let scrollview = CustomScrollView()
            return scrollview
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Learn"
        view.backgroundColor = .systemBackground
        
        AddWordsButton.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
        
        
    }
    
    
    @objc private func ButtonTapped()
    {
        let vc = AddWordsViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(scrollview)
        scrollview.addSubview(AddWordsButton)
        
       
        scrollview.addSubview(ListButton)
        
        scrollview.contentSize = CGSize(width: view.frame.size.width, height: 2200)
        Layout()
    }
    
    func Layout(){
        scrollview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollview.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0).isActive = true
        scrollview.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        
        AddWordsButton.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor).isActive = true
        AddWordsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        AddWordsButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        AddWordsButton.topAnchor.constraint(equalTo: scrollview.topAnchor, constant: 20).isActive = true
        
      
        ListButton.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor).isActive = true
        ListButton.heightAnchor.constraint(equalToConstant: 450).isActive = true
        ListButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        ListButton.topAnchor.constraint(equalTo: scrollview.topAnchor, constant: 150).isActive = true
    }
    
}
