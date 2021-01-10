//
//  QuizViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 28.12.20.
//

import UIKit

class QuizViewController: UIViewController {

    var Num = Int()
    var LanguageOneWords: [String] = []
    var LanguageTwoWords: [String] = []
    
    var TimesAlreadyCalled: Int!
    
    
    var NumWordsAsked = Int()
    var NumWordsCorrect = Int()
    
    var timer: Timer!
    var timeleft = 20
    var progress = 1.0
        
    let timeLabel: UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .systemGreen
            label.font = .boldSystemFont(ofSize: 18)
            label.text = "20 seconds left"
            
            return label
        }()
    
    let timeView: UIProgressView =
        {
            let view = UIProgressView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.progress = 1.0
            view.progressTintColor = .systemBlue
            view.trackTintColor = .gray
            view.layer.cornerRadius = 6.5
            
            return view
        }()
    
    var TimeViewMultiplier = 1.0
    
    let TextField: UITextField =
        {
            let Textfield = UITextField()
            Textfield.translatesAutoresizingMaskIntoConstraints = false
            Textfield.autocorrectionType = .no
            Textfield.placeholder = "Type in your Guess..."
            Textfield.borderStyle = .roundedRect
            Textfield.returnKeyType = .done
            
            //Textfield.enablesReturnKeyAutomatically = true
            
            return Textfield
        }()

    
    let WordLabel: UILabel =
        {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 25)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    let SolutionWordLabel: UILabel =
        {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 17)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
    
    var WordToCompareTwo: String!
    var AlreadyUsedWords = [String]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        //navigationController?.navigationBar.delegate = self
        title = "Quiz"
        
        TimesAlreadyCalled = 0
        
       SetupTimer()
       SetUpLabel()
       SetRandomWord()
       SetupTextField()

        navigationController?.delegate = self
        
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
   
}



extension QuizViewController
{
    //Timer related Stuff
    func SetupTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TimerdidEnded), userInfo: nil, repeats: true)
    
    
        
        view.addSubview(timeView)
        timeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        timeView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.005).isActive = true
        timeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        timeView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: 10).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    
    
    func ResetEverything()
    {
        TimesAlreadyCalled = 0
    
        
        view.backgroundColor = .systemBackground
        
        timeleft = 20
        progress = 1.0

        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(TimerdidEnded), userInfo: nil, repeats: true)
        
        
        SetRandomWord()
        TextField.text = ""
        
        
        //view.layoutIfNeeded()
    }
    
    
    
    @objc func TimerdidEnded()
    {

        if(TextField.text?.lowercased() == WordToCompareTwo.lowercased())
        {
            timeLabel.text = "20 seconds left"
            timeView.setProgress(1.0, animated: true)
        }
        else if(timeleft <= 0)
        {
          //timer.invalidate()
          //timer = nil
          view.backgroundColor = .systemRed
          
          timeLabel.text = "20 seconds left"
          timeView.setProgress(1.0, animated: true)
          
          TimesAlreadyCalled += 1
            
          if(TimesAlreadyCalled == 1)
          {
            SolutionWordLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
              self.ResetEverything()
            })
          }
            
        }
        
        else
        {
          timeleft -= 1
        
          timeLabel.text = "\(timeleft) seconds left"
        
          progress -= 1 / 20
        
          timeView.setProgress(Float(progress), animated: true)
            
            if(timeleft > 14)
            {
                timeLabel.textColor = .systemGreen
            }
            else if(timeleft > 8 && timeleft < 15)
            {
                timeLabel.textColor = .systemYellow
            }
            else
            {
                timeLabel.textColor = .systemRed
            }
      
          view.layoutIfNeeded()
        
          
           
        }
        
        
        
    }

}



extension QuizViewController
{
    // Words related Stuff
    
    
    func SetUpLabel()
    {
        view.addSubview(WordLabel)
        
        WordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        WordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        
        view.addSubview(SolutionWordLabel)
        SolutionWordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SolutionWordLabel.topAnchor.constraint(equalTo: WordLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    
    func SetRandomWord()
    {
        var randomname = LanguageOneWords.randomElement()
        
        if(AlreadyUsedWords.isEmpty == false)
        {
            
        
          if(AlreadyUsedWords.count == LanguageOneWords.count)
          {
            AlreadyUsedWords.removeAll()
          }
            
        }
     
        if(AlreadyUsedWords.contains(randomname ?? ""))
        {
            var Runs = 1
            
            for item in 0...Runs
            {
                randomname = LanguageOneWords.randomElement()
                
                if(AlreadyUsedWords.contains(randomname ?? ""))
                {
                    Runs += 1
                }
                else
                {
                  for item in 0..<LanguageOneWords.count
                  {
                    if(randomname == LanguageOneWords[item])
                    {
                     WordToCompareTwo = LanguageTwoWords[item]
                    }
                  }
            
                   WordLabel.text = randomname
              
                   AlreadyUsedWords.append(randomname ?? "")
              
                   SolutionWordLabel.text = "Correct answer would have been: \(WordToCompareTwo ?? "filler")"
                   SolutionWordLabel.isHidden = true
                    break
                }
            }
            
            
        }
        
        else
        {
          for item in 0..<LanguageOneWords.count
          {
          if(randomname == LanguageOneWords[item])
          {
              WordToCompareTwo = LanguageTwoWords[item]
          }
          }
      
          WordLabel.text = randomname
        
          //AlreadyUsedWords.append(randomname ?? "")
        
          SolutionWordLabel.text = "Correct answer would have been: \(WordToCompareTwo ?? "filler")"
          SolutionWordLabel.isHidden = true
        }
       
    
    

    }
      
}



extension QuizViewController: UITextFieldDelegate
{
    
    
 
    func SetupTextField()
    {
        
        view.addSubview(TextField)
        
        TextField.topAnchor.constraint(equalTo: SolutionWordLabel.bottomAnchor, constant: 120).isActive = true
        TextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        TextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        TextField.delegate = self
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        navigationController?.navigationBar.isHidden = true
        
        animateViewMoving(up: true, moveValue: 150)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print("finished!!")
       
        navigationController?.navigationBar.isHidden = false
        animateViewMoving(up: false, moveValue: 150)
        
    
       
        
        let WordArray = RemoveJunkagain(WordOne: textField.text ?? " ", WordTwo: WordToCompareTwo)
       
        if(WordsAreEqual(WordOne: WordArray[0], WordTwo: WordArray[1]))
        {
            view.backgroundColor = .systemGreen
    
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.ResetEverything()
            })
        }
        else
        {

            print("\(textField.text?.lowercased() ?? "filler") != \(WordToCompareTwo.lowercased()) ")
            
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //view.endEditing(true)
        return true
    }
    
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.animate(withDuration: 0.3)
        {
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        }
    }
    
    
    func RemoveJunkagain(WordOne: String, WordTwo: String) -> [String]
    {
      
        var FirstWord = WordOne
        var SecondWord = WordTwo
        
        
        for item in WordOne
        {
            if(item == " ")
            {
                FirstWord.remove(at: FirstWord.firstIndex(of: item) ?? FirstWord.startIndex)
            }
        }
        
        
        for item in WordTwo
        {
            if(item == " ")
            {
                SecondWord.remove(at: SecondWord.firstIndex(of: item) ?? SecondWord.startIndex)
            }
        }
        
        let Array = [FirstWord, SecondWord]
        
        return Array
    }
    
    
    func WordsAreEqual(WordOne: String, WordTwo: String) -> Bool {
        
        if(WordOne.caseInsensitiveCompare(WordTwo) == .orderedSame)
        {
            return true
        }
        else
        {
            var One = WordOne.count
            var Two = WordTwo.count
            
            for item in WordOne
            {
                print(item)
            }
            for item in WordTwo
            {
                print(item)

            }
            
            print(One)
            print(Two)
        }
        
        
        return false
    }
  
}


extension QuizViewController:  UINavigationControllerDelegate
{
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        
        var Decision = Bool()
        
        let Alert = UIAlertController(title: "Do you really want to Quit?", message: nil, preferredStyle: .alert)
        
        let LeaveAction = UIAlertAction(title: "Quit", style: .destructive)
        {(action) in
            Decision = true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        {(action) in
            Decision = false
        }
        
        Alert.addAction(LeaveAction)
        Alert.addAction(cancelAction)
        
        self.present(Alert, animated: true, completion: nil)
        
        if(Decision == true)
        {
            return true
        }
        else
        {
            return false
        }
    }
    

    
    
}
