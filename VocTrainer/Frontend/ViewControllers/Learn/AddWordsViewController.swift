//
//  AddWordsViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 15.10.20.
//

import UIKit
import AVFoundation

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
        
     
        
        let ButtonImageHeight = -UIScreen.main.bounds.height * 0.225
        let ButtonImageWidth = -UIScreen.main.bounds.width * 0.675
       
        TopButton.imageView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TopButton.imageView?.widthAnchor.constraint(equalTo: TopButton.widthAnchor, constant: ButtonImageWidth).isActive = true
        TopButton.imageView?.heightAnchor.constraint(equalTo: TopButton.heightAnchor, constant: ButtonImageHeight).isActive = true
        TopButton.imageView?.topAnchor.constraint(equalTo: TopButton.topAnchor, constant: 30).isActive = true
        
        BottomButton.imageView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BottomButton.imageView?.widthAnchor.constraint(equalTo: BottomButton.widthAnchor, constant: ButtonImageWidth).isActive = true
        BottomButton.imageView?.heightAnchor.constraint(equalTo: BottomButton.heightAnchor, constant: ButtonImageHeight).isActive = true
        BottomButton.imageView?.topAnchor.constraint(equalTo: BottomButton.topAnchor, constant: 30).isActive = true
    
       
    }
    
    @objc func TypeButtonTapped()
    {
        let vc = TypeInWordsViewcontroller()
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



class TypeInWordsViewcontroller: UIViewController
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        
        PickerView.delegate = self
        PickerView.dataSource = self
        
        title = "Add Words"
        
        view.addSubview(PickerView)
        view.addSubview(Title)
        
        view.addSubview(Continue)
        Continue.addTarget(self, action: #selector(ContinueButtonTapped), for: .touchUpInside)
        
        SetLayout()
        
    }
    
    func SetLayout()
    {
        Title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        
        PickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        
        Continue.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Continue.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120).isActive = true
        Continue.widthAnchor.constraint(equalToConstant: 350).isActive = true
        Continue.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    @objc func ContinueButtonTapped()
    {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension TypeInWordsViewcontroller: UIPickerViewDelegate, UIPickerViewDataSource
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
    
        var LanguageOne = ListOfLanguages[pickerView.selectedRow(inComponent: 0)]
        var Languagetwo = ListOfLanguages[pickerView.selectedRow(inComponent: 1)]
       
       StoreLanguageChoice(LanguageOne, Languagetwo)
       Test()
        
    }
   
}






class ScanWordsViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
       
        
        
    }
    
    func ConfigureCamera()
    {
     
        
        
    }
}
