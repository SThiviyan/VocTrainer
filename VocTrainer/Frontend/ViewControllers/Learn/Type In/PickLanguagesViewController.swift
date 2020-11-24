//
//  PickLanguages.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 24.10.20.
//

import UIKit

//just to commit files to github

class PickLanguagesViewcontroller: UIViewController
{
    
    let ListOfLanguages = ["English","Spanish","French","German","Portuguese","Dutch","Japanese","Italian"]
    
    let PickerView: UIPickerView =
        {
            let PickerView = UIPickerView()
            PickerView.translatesAutoresizingMaskIntoConstraints = false
            return PickerView
        }()
    
    let Title: UILabel =
        {
            let text = UILabel()
            text.text = "Choose your Language Pair:"
            text.font = .boldSystemFont(ofSize: 28)
            
            text.translatesAutoresizingMaskIntoConstraints = false
            
            return text
        }()
    
    let Continue: CustomButton =
        {
            let button = CustomButton()
            button.setTitle("Continue", for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 18)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }()
    
    let Text: UILabel =
        {
            let Text = UILabel()
            Text.text = "Please Choose two different Languages"
            Text.font = .boldSystemFont(ofSize: 14)
            Text.textColor = .systemBackground
            Text.textAlignment = .center
            Text.translatesAutoresizingMaskIntoConstraints = false
            
            return Text
        }()
    
    var FirstLanguageChoice = String()
    var SecondLanguageChoice = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        
        PickerView.delegate = self
        PickerView.dataSource = self
        
        title = "Pick Languages"
        
        view.addSubview(PickerView)
        view.addSubview(Title)
        view.addSubview(Text)
        
        view.addSubview(Continue)
        Continue.addTarget(self, action: #selector(ContinueButtonTapped), for: .touchUpInside)
        
        SetLayout()
        
    }
    
    func SetLayout()
    {
        Title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        
        PickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        
        Continue.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Continue.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120).isActive = true
        Continue.widthAnchor.constraint(equalToConstant: 350).isActive = true
        Continue.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        Text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Text.bottomAnchor.constraint(equalTo: Continue.topAnchor, constant: -40).isActive = true
        
    }
    
    @objc func ContinueButtonTapped()
    {
        let vc = TypeInViewController()
        vc.LabelLanguageOne.text = FirstLanguageChoice
        vc.LabelLanguagetwo.text = SecondLanguageChoice
        if(FirstLanguageChoice != SecondLanguageChoice)
        {
            Text.textColor = .systemBackground
            navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            Text.textColor = .systemRed
        }
    }
    
    
}

extension PickLanguagesViewcontroller: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in PickerView: UIPickerView) -> Int{
        return 2
    }
    
    func pickerView(_ PickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int
    {
        return ListOfLanguages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           if component == 0 {
               return ListOfLanguages[row]
           }else {
               return ListOfLanguages[row]
           }
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        FirstLanguageChoice = ListOfLanguages[pickerView.selectedRow(inComponent: 0)]
        SecondLanguageChoice = ListOfLanguages[pickerView.selectedRow(inComponent: 1)]
      
        
    }
    
   
    
    
    
   
}

