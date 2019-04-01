//
//  LoginVC.swift
//  YouthLine
//
//  Created by NOKEYUAN on 2019-03-30.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit
import FirebaseUI


class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //header view
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        headerView.backgroundColor = .white
        
        
        let imageView: UIImageView = UIImageView(frame: CGRect(x: ScreenWidth/4, y: ScreenHeight/5, width: 200, height: 200))
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "Default")

         headerView.addSubview(imageView)
        
        // This button
        let button = UIButton()
        button.frame = CGRect(x:ScreenWidth/5, y:ScreenHeight/2.5, width: 250, height: 50)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = UIColor(red:0.97, green:0.80, blue:0.80, alpha:1.0)
        button.setTitle("Login ", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        headerView.addSubview(button)
        view.addSubview(headerView)
        
    }
    
    //button action for resoucres
    @objc func buttonAction(sender: UIButton!) {
        let authUI = FUIAuth.defaultAuthUI()
        
        // Check that it isn't nil
        guard authUI != nil else {
            return
        }
        
        // Set delegate and specify sign in options
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        
        // Get the auth view controller and present it
        let authViewController = authUI!.authViewController()
        present(authViewController, animated: true, completion: nil)
        
    }
    
    
}

extension LoginVC: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        // Check for error
        guard error == nil else {
            return
        }
        
//        let subvc = MainVC()
//        self.definesPresentationContext = true
//        self.present(subvc, animated: true, completion: nil)
    }
    
}
