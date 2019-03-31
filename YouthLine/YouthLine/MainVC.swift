//
//  MainVC.swift
//  YouthLine
//
//  Created by NOKEYUAN on 2019-03-30.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class MainVC: ESTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let barController = ESTabBarController()
        self.delegate = self as? UITabBarControllerDelegate
        
        let vc1 = HomePageVC()
        let vc2 = EventBaseVC()
        let vc3 = ResourceBaseVC()
        let vc4 = PersonalPageVC()
        
        
        
        vc2.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "Events", image: UIImage(named: "event"), selectedImage: UIImage(named: "event_color"))
        vc1.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "HomePage", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_color"))
        vc3.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "Resources", image: UIImage(named: "books"), selectedImage: UIImage(named: "books_color"))
        vc4.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "PersonalPage", image: UIImage(named: "person"), selectedImage: UIImage(named: "person_color"))
        
        
        let n1 = UINavigationController.init(rootViewController: vc1)
        let n2 = UINavigationController.init(rootViewController: vc2)
        let n3 = UINavigationController.init(rootViewController: vc3)
        let n4 = UINavigationController.init(rootViewController: vc4)
        
        self.viewControllers = [n1, n2, n3, n4]
        
        
        // Do any additional setup after loading the view.
    }
    
   



}
