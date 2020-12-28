//
//  ViewController.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 12.10.20.
//

import UIKit

//just to commit files to github

class ViewController: UIViewController {

    let tabBarVC = UITabBarController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Tap()
     
    }
    
     func Tap()
    {
        /*
         To have the border on the Top add UINavigationController(rootViewController: -ViewController you wanna see-)
         
         */
        
        let vc1 = UINavigationController(rootViewController: LearnMenuViewController())
        let vc2 = UINavigationController(rootViewController: MainMenuViewController())
        let vc3 = UINavigationController(rootViewController: DictionaryMenuViewController())
        
        vc1.navigationBar.prefersLargeTitles = true
        vc2.navigationBar.prefersLargeTitles = true
        vc3.navigationBar.prefersLargeTitles = true
    
        
        vc1.title = "Learn"
        vc2.title = "Home"
        vc3.title = "Dictionary"
        
        
        tabBarVC.setViewControllers([vc2, vc1, vc3], animated: true)

        guard let items = tabBarVC.tabBar.items else {
            return
        }

        
        let images = ["house", "textformat.abc",  "books.vertical"]
        
        for x in 0..<items.count{
            items[x].image = UIImage(systemName: images[x])
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
                
        self.view.addSubview(tabBarVC.view)
       
    }

}









