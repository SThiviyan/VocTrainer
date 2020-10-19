//
//  TutorialViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 15.10.20.
//

import UIKit

class TutorialViewController: UIViewController
{
    let button: CustomButton =
    {
        let button = CustomButton()
        button.setTitle("Open Test", for: .normal)
        
        return button
    }()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
       
        view.backgroundColor = .systemBackground
        
        
        button.addTarget(self, action: #selector(buttonpressed), for: .touchUpInside)
        view.addSubview(button)
        
        SetLayout()
        
    }
    
    func SetLayout()
    {
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    @objc private func buttonpressed()
    {
        //Test code for a new Kind of Changing viewcontroller
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
