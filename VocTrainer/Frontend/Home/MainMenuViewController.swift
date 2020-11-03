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
  
    let LanguageImageView: UIImageView =
        {
            let imageView = UIImageView(image: #imageLiteral(resourceName: "language.png"))
            
            imageView.translatesAutoresizingMaskIntoConstraints = false

            return imageView
        }()
    
    let TutorialTitleText: UITextView =
        {
            let TextView = UITextView()
            TextView.text = "Welchome! To learn more about VocabTrainer press here"
            
            TextView.translatesAutoresizingMaskIntoConstraints = false
            TextView.font = UIFont.boldSystemFont(ofSize: 20)
            TextView.isEditable = false
            TextView.textAlignment = .center
            TextView.isScrollEnabled = false
            
            return TextView
        }()
    
    let TutorialText: UITextView =
        {
           let TextView = UITextView()
            
            TextView.text = "To Learn about the features of VocabTrainer you can look up the documentation right here"
            
            TextView.translatesAutoresizingMaskIntoConstraints = false
            TextView.font = .italicSystemFont(ofSize: 15)
            TextView.textColor = .systemGray
            TextView.isEditable = false
            TextView.textAlignment = .center
            TextView.isScrollEnabled = false
            
            return TextView
        }()
    
    
   
    let GoToTutorialButton: CustomButton =
        {
           let Button = CustomButton()
            
            Button.setTitle("Open Documentation", for: .normal)
            
            return Button
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "Home"
        
        GoToTutorialButton.addTarget(self, action: #selector(OpenTutorial), for: .touchUpInside)
        
       
        view.addSubview(LanguageImageView)
        view.addSubview(TutorialTitleText)
        view.addSubview(TutorialText)
        view.addSubview(GoToTutorialButton)
        
        
        SetupLayout()

    }
    
    
   
    private func SetupLayout()
    {
        LanguageImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LanguageImageView.topAnchor.constraint(equalTo: view.topAnchor , constant:200).isActive = true
        LanguageImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        LanguageImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        TutorialTitleText.topAnchor.constraint(equalTo: LanguageImageView.bottomAnchor, constant: 50).isActive = true
        TutorialTitleText.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        TutorialTitleText.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        TutorialTitleText.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: 0).isActive = true
        
    
        TutorialText.topAnchor.constraint(equalTo: LanguageImageView.bottomAnchor, constant: 125).isActive = true
        TutorialText.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        TutorialText.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        TutorialText.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: 0).isActive = true
        
        
        GoToTutorialButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        GoToTutorialButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        GoToTutorialButton.widthAnchor.constraint(equalToConstant: 350 ).isActive = true
        GoToTutorialButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
    }
    
    
    
    @objc private func OpenTutorial()
    {
       let rootvc = TutorialViewController()
       let navVC = UINavigationController(rootViewController: rootvc)
        
        present(navVC, animated: true)
    }
    

    
}
