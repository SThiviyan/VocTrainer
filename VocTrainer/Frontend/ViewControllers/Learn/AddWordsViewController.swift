//
//  AddWordsViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 15.10.20.
//

import UIKit

class AddWordsViewController: UIViewController {

  
   
    let Text: UILabel =
        {
            let Text = UILabel()
            Text.text = "Choose the way you want to add the words:"
            Text.translatesAutoresizingMaskIntoConstraints = false
            
            return Text
        }()
    
    let ScanImage: UIImageView =
        {
            let imageView = UIImageView(image: UIImage(systemName: "􀎾"))
            
            imageView.translatesAutoresizingMaskIntoConstraints = false

            return imageView
        }()
    
    let TypeImage: UIImageView =
        {
            let imageView = UIImageView(image: UIImage(systemName: "􀈿"))
            
            imageView.translatesAutoresizingMaskIntoConstraints = false

            return imageView
        }()
   
    
    let TopButton: CustomButton =
        {
            let button = CustomButton()
            button.setImage(UIImage(systemName: "doc.text"), for: UIControl.State.normal )
            button.setTitle("Type in", for: UIControl.State.normal)
            
            
            return button
        }()
    
    let BottomButton: CustomButton =
        {
            let button = CustomButton()
            button.setImage(UIImage(systemName: "doc.text.viewfinder" ), for: UIControl.State.normal)
            button.setTitle("Scan", for: UIControl.State.normal)
           
           
            return button
        }()
    
 
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Add Words"
        
        TopButton.addTarget(self, action: #selector(TypeButtonTapped), for: .touchUpInside)
        BottomButton.addTarget(self, action: #selector(ScanButtonTapped), for: .touchUpInside)
        
        
        view.addSubview(TopButton)
        view.addSubview(BottomButton)
        view.addSubview(Text)
        
            
      
     
        Layout()
    }
    
    func Layout()
    {
        TopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TopButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60 ).isActive = true
        TopButton.heightAnchor.constraint(equalTo: view.heightAnchor ,constant: -575).isActive = true
        TopButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
        
        BottomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BottomButton.topAnchor.constraint(equalTo: TopButton.bottomAnchor, constant: 10).isActive = true
        BottomButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
        BottomButton.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -575).isActive = true
        
        Text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Text.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
       
    
       
    }
    
    @objc func TypeButtonTapped()
    {
        print("Type Button Tapped")
        
    }
    
    @objc func ScanButtonTapped()
    {
        print("Scan Button Tapped")
    }
  

}
