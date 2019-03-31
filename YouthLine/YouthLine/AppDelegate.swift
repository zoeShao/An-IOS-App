//
//  AppDelegate.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let barController = ESTabBarController()
        barController.delegate = self as? UITabBarControllerDelegate
        self.window?.rootViewController = barController
        self.window?.makeKeyAndVisible()
        
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
        
        
        barController.viewControllers = [n1, n2, n3, n4]
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}



