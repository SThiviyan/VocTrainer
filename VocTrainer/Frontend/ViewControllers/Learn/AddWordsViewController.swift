//
//  AddWordsViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 15.10.20.
//

import UIKit


class AddWordsViewController: UIViewController {

  
 
    
    let TopButton: CustomButton =
        {
            let Image = UIImage(systemName: "doc.text")
            
            
            let button = CustomButton()
            button.setImage(Image, for: UIControl.State.normal )
            button.imageView?.tintColor = .white
            button.setTitle("Type Words in", for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 35)
            
            button.titleEdgeInsets = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 20)
            
            button.imageView?.translatesAutoresizingMaskIntoConstraints = false
           
            return button
        }()
    
    let BottomButton: CustomButton =
        {
        
            let button = CustomButton()
            button.setImage(UIImage(systemName: "doc.text.viewfinder" ), for: UIControl.State.normal)
            button.imageView?.tintColor = .white
            button.setTitle("Scan", for: UIControl.State.normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 35)
           
            button.titleEdgeInsets = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 20)
            button.imageView?.translatesAutoresizingMaskIntoConstraints = false

           
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
        
            
      
     
        Layout()
    }
    
    func Layout()
    {
        TopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TopButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40 ).isActive = true
        TopButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
        
        BottomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BottomButton.topAnchor.constraint(equalTo: TopButton.bottomAnchor, constant: 30).isActive = true
        BottomButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
        
        
        
        let ButtonPrePos =  -UIScreen.main.bounds.height
        let ButtonPos = ButtonPrePos * 0.5
        
        TopButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: ButtonPos).isActive = true
        BottomButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: ButtonPos).isActive = true
        
     
        
       
       
        TopButton.imageView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TopButton.imageView?.widthAnchor.constraint(equalToConstant: 75).isActive = true
        TopButton.imageView?.heightAnchor.constraint(equalToConstant: 75).isActive = true
        TopButton.imageView?.topAnchor.constraint(equalTo: TopButton.topAnchor, constant: 30).isActive = true
        
        BottomButton.imageView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BottomButton.imageView?.widthAnchor.constraint(equalToConstant: 75).isActive = true
        BottomButton.imageView?.heightAnchor.constraint(equalToConstant: 75).isActive = true
        BottomButton.imageView?.topAnchor.constraint(equalTo: BottomButton.topAnchor, constant: 30).isActive = true
    
       
    }
    
    @objc func TypeButtonTapped()
    {
        let vc = PickLanguagesViewcontroller()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func ScanButtonTapped()
    {
        let vc = ScanWordsViewController()
        vc.modalPresentationStyle = .overFullScreen
        navigationController?.present(vc, animated: true)
    }
  

}











