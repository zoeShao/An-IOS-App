//
//  ResourcePageVC.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit

class ResourcePageVC: UITableViewController {
    let transition = SlideInTransition()
    var resourcesCollection = [String: [Resource]]()
    var resources: [Resource] = []
    
    
    //    lazy var searchTextField: UITextField = {
    //        let textField = UITextField.init(frame: CGRect(x: 15, y: StatusBarHeight + 10, width: ScreenWidth - 100, height: 30))
    //        textField.placeholder = "Enter search texts here"
    //        textField.layer.masksToBounds = true
    //        textField.layer.cornerRadius = 5
    //        textField.textAlignment = NSTextAlignment.center
    //        textField.backgroundColor = RGBColor(240, 240, 240)
    //        textField.delegate = self
    //        return textField
    //    }()
    //
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ResourceCell.self, forCellReuseIdentifier: "ResourceCell")
        
        resourcesCollection = createDic()
        resources = resourcesCollection["all"]!
        
        
        //        initSearchBar()
        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(didTapFilter(sender:)))
    }
    
    //    func initSearchBar() {
    //        view.addSubview(searchTextField)
    //    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    //        navigationController?.setNavigationBarHidden(true, animated: false)
    //    }
    //
    
    func createDic() -> [String: [Resource]] {
        var tempResources:[String: [Resource]] = ["all":[], "settlement":[], "faith":[], "sex": []]
        //        var tempResources = [String: [Resource]]()
        
        let resource1 = Resource(image: #imageLiteral(resourceName: "AppIcon_76x76_"), title: "LGBT issues in Canada’s Immigration and Refugee System")
        let resource2 = Resource(image: #imageLiteral(resourceName: "Tabbar_Notifications_Normal_28x28_"), title: "Open Hearts: Resources for Affirming Ministries in The United Church of Canada")
        let resource3 = Resource(image: #imageLiteral(resourceName: "Tabbar_More_Playing_Highlight_28x28_"), title: "Yes No Maybe: sex, kink, and language spreadsheets")
        
        tempResources["all"]!.append(resource1)
        tempResources["all"]!.append(resource2)
        tempResources["all"]!.append(resource3)
        
        tempResources["settlement"]!.append(resource1)
        tempResources["faith"]!.append(resource2)
        tempResources["sex"]!.append(resource3)
        
        return tempResources
    }
    
    @objc func didTapFilter(sender: UIBarButtonItem) {
        let menuViewController: MenuViewController = MenuViewController()
        menuViewController.didTapMenuTypte = { menuType in
            print(menuType)
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
        self.tabBarController!.tabBar.items![0].isEnabled = false
        self.tabBarController!.tabBar.items![1].isEnabled = false
        self.tabBarController!.tabBar.items![3].isEnabled = false
        
    }
    
    func transitionToNew(_ menuType: MenuType) {
        
        switch menuType {
        case .all:
            resources = resourcesCollection["all"]!
            self.tableView.reloadData()
        case .settlement:
            resources = resourcesCollection["settlement"]!
            self.tableView.reloadData()
        case .faith:
            resources = resourcesCollection["faith"]!
            self.tableView.reloadData()
        case .sex:
            resources = resourcesCollection["sex"]!
            self.tableView.reloadData()
        default:
            break
        }
    }
    
    
    
}

extension ResourcePageVC: UITextFieldDelegate, UIViewControllerTransitioningDelegate {
    
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return resources.count
    //    }
    //
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let resource = resources[indexPath.row]
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCell") as! ResourceCell
    //        cell.setImage(resource: resource)
    //        return cell
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resource = resources[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCell") as! ResourceCell
        cell.setImage(resource: resource)
        return cell
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        self.tabBarController!.tabBar.items![0].isEnabled = true
        self.tabBarController!.tabBar.items![1].isEnabled = true
        self.tabBarController!.tabBar.items![3].isEnabled = true
        return transition
    }
    
    //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    //        let vc = EventSearchVC()
    //        navigationController?.pushViewController(vc, animated: false)
    //        return false
    //    }
}
