//
//  NamingViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 28.10.20.
//

import UIKit

//just to commit files to github

class NamingViewController: UIViewController
{
    
    var LanguageOne = String()
    var LanguageTwo = String()
    var LanguageOneWords = [String()]
    var LanguageTwoWords = [String()]
    var SectionName = String()
    

    let Label: UILabel =
        {
          let Label = UILabel()
            Label.text = "Name this chapter of your Vocabulary:"
            Label.font = .boldSystemFont(ofSize: 18)
            Label.translatesAutoresizingMaskIntoConstraints = false
            Label.numberOfLines = 0
          return Label
        }()
    
    let FinishButton: CustomButton =
        {
            let button = CustomButton()
            button.setTitle("Finish", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }()
    
    let TextField: UITextField =
        {
            let Textfield = UITextField()
            Textfield.translatesAutoresizingMaskIntoConstraints = false
            Textfield.borderStyle = .roundedRect
            Textfield.placeholder = "P.149 --English Book"
            
            return Textfield
        }()
    
    let ErrorLabel: UILabel =
        {
            let Label = UILabel()
            Label.text = "Name is already in use"
            Label.font = .boldSystemFont(ofSize: 14)
            Label.textColor = .systemRed
            Label.translatesAutoresizingMaskIntoConstraints = false
            
            
            return Label
        }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        title = "Naming"
        
        
        FinishButton.addTarget(self, action: #selector(GoToRootviewController), for: .touchUpInside)
        view.addSubview(FinishButton)
        
        view.addSubview(Label)
        view.addSubview(TextField)
        TextField.delegate = self
        
        
        setLayout()
        initializeHideKeyboard()
    }
    
    
    func setLayout()
    {
        FinishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        FinishButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120).isActive = true
        FinishButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        FinishButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150).isActive = true
        Label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        TextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        TextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        TextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func GoToRootviewController(){
    //Code to go back to LearnMenuViewController
        if(CheckIfValid())
        {
          ErrorLabel.removeFromSuperview()
          StoreEverything()
          navigationController?.popToRootViewController(animated: true)
        }
        else
        {
            view.addSubview(ErrorLabel)
            ErrorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            ErrorLabel.bottomAnchor.constraint(equalTo: FinishButton.topAnchor, constant: -30).isActive = true
        }
    }
    
    func StoreEverything()
    {
        let List = WordList(name: SectionName, TimeAdded: Date(), LanguageOne: LanguageOne, LanguageTwo: LanguageTwo, WordsLanguageOne: LanguageOneWords, WordsLanguageTwo: LanguageTwoWords)
         
        List.SaveItem()
     }
    
    
    func CheckIfValid() -> Bool
    {
        let Data = DataManager.LoadAll(WordList.self)
        
        for item in 0..<Data.count
        {
            if(Data[item].name == SectionName)
            {
                return false
            }
        }
        
        return true
    }
    
}


extension NamingViewController: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField) {
        SectionName = textField.text ?? "filler"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


extension NamingViewController {
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


