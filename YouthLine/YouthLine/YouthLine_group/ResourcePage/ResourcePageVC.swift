////
////  ResourcePageVC.swift
////  YouthLine
////
////  Created by Yecheng Song on 2019-03-09.
////  Copyright © 2019 RainbowWarrior. All rights reserved.
////
//
//import UIKit
////var menuSelected = "settlement"
//var resourcesCollection = [String: [Resource]]()
//class ResourcePageVC: UITableViewController {
//    //    let transition = SlideInTransition()
////    var resourcesCollection = [String: [Resource]]()
//    var resources: [Resource] = []
//    //    var menuSelected = "all"
//    
//    
//    //    lazy var searchTextField: UITextField = {
//    //        let textField = UITextField.init(frame: CGRect(x: 15, y: StatusBarHeight + 10, width: ScreenWidth - 100, height: 30))
//    //        textField.placeholder = "Enter search texts here"
//    //        textField.layer.masksToBounds = true
//    //        textField.layer.cornerRadius = 5
//    //        textField.textAlignment = NSTextAlignment.center
//    //        textField.backgroundColor = RGBColor(240, 240, 240)
//    //        textField.delegate = self
//    //        return textField
//    //    }()
//    
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.white
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(ResourceCell.self, forCellReuseIdentifier: "ResourceCell")
//        
//        resourcesCollection = createDic()
////        print(menuSelected)
////        resources = resourcesCollection["all"]!
//        print(resources)
//        
//        
//        //        initSearchBar()
//        // Do any additional setup after loading the view.
//        //        self.navigationItem.titleView = searchTextField
//        //        if #available(iOS 11.0, *) {
//        //            navigationController?.navigationBar.prefersLargeTitles = true
//        //        }
//        //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(didTapFilter(sender:)))
//    }
//    
//    //    func initSearchBar() {
//    //        view.addSubview(searchTextField)
//    //    }
//    
//    //        override func viewWillAppear(_ animated: Bool) {
//    //            super.viewWillAppear(animated)
//    //
//    //            navigationController?.setNavigationBarHidden(true, animated: false)
//    //        }
//    
//    
//    func createDic() -> [String: [Resource]] {
//        var tempResources:[String: [Resource]] = ["all":[], "settlement":[], "faith":[], "sex": [], "forms": [], "service":[], "education":[], "type":[]]
//        //        var tempResources:[String: [Resource]] = ["all":[], "settlement":[], "faith":[], "sex": []]
//        
//        let resource1 = Resource(image: #imageLiteral(resourceName: "settlement"), title: "Settlement.Org: Sexual Orientation and Gender Identity", url: URL(string: "https://settlement.org/ontario/health/sexual-and-reproductive-health/sexual-orientation-and-gender-identity/")!)
//        let resource2 = Resource(image: #imageLiteral(resourceName: "forward_partners"), title: "transACTION: A Transgender Curriculum and Learner's Guide For Churches and Religious Institutions", url: URL(string: "https://www.youthline.ca/get-support/links-resources/")!)
//        let resource3 = Resource(image: #imageLiteral(resourceName: "BexTalksSex"), title: "Yes No Maybe: sex, kink, and language spreadsheets", url: URL(string: "https://www.bextalkssex.com/yes-no-maybe/")!)
//        let resource4 = Resource(image: #imageLiteral(resourceName: "form"), title: "How Do I Change the Sex Designation on my Identity Documents?", url: URL(string: "https://jfcy.org/en/rights/government-issued-identification/")!)
//        let resource5 = Resource(image: #imageLiteral(resourceName: "TransCareGuide"), title: "Trans Primary Care: My Guide to Caring for Trans and Gender-Diverse Clients", url: URL(string: "https://www.rainbowhealthontario.ca/TransHealthGuide/")!)
//        let resource6 = Resource(image: #imageLiteral(resourceName: "thebodyisnotanapology"), title: "The Body is Not An Apology", url: URL(string: "https://thebodyisnotanapology.com/")!)
//        let resource7 = Resource(image: #imageLiteral(resourceName: "2spirit"), title: "Briarpatch Magazine: Hearing Two Spirits", url: URL(string: "https://briarpatchmagazine.com/articles/view/hearing-two-spirits")!)
//        tempResources["all"]!.append(resource1)
//        tempResources["all"]!.append(resource2)
//        tempResources["all"]!.append(resource3)
//        tempResources["all"]!.append(resource4)
//        tempResources["all"]!.append(resource5)
//        tempResources["all"]!.append(resource6)
//        tempResources["all"]!.append(resource7)
//        tempResources["settlement"]!.append(resource1)
//        tempResources["faith"]!.append(resource2)
//        tempResources["sex"]!.append(resource3)
//        tempResources["forms"]!.append(resource4)
//        tempResources["service"]!.append(resource5)
//        tempResources["education"]!.append(resource6)
//        tempResources["type"]!.append(resource7)
//        
//        
//        return tempResources
//    }
//    
//    func didTapFilter(menuViewController: MenuViewController) {
//        //        print(123)
//        //        let menuViewController: MenuViewController = MenuViewController()
//        //        menuViewController.didTapMenuTypte = { menuType in
//        //            print(menuType)
//        //            self.transitionToNew(menuType)
//        //        }
//        //        menuViewController.modalPresentationStyle = .overCurrentContext
//        //        menuViewController.transitioningDelegate = self
//        //        present(menuViewController, animated: true)
//        //        self.tabBarController!.tabBar.items![0].isEnabled = false
//        //        self.tabBarController!.tabBar.items![1].isEnabled = false
//        //        self.tabBarController!.tabBar.items![3].isEnabled = false
//        
//    }
//    
//        func transitionToNew(_ menuType: MenuType) {
//            switch menuType {
//            case .all:
////                print(resourcesCollection["all"]!)
//                resources = resourcesCollection["all"]!
//                self.tableView.reloadData()
//    
//            case .settlement:
//                resources = resourcesCollection["settlement"]!
//                print(resourcesCollection["settlement"]!)
//                self.tableView.reloadData()
//            case .faith:
//                resources = resourcesCollection["faith"]!
//                self.tableView.reloadData()
//            case .sex:
//                resources = resourcesCollection["sex"]!
//                self.tableView.reloadData()
//            case .forms:
//                resources = resourcesCollection["forms"]!
//                self.tableView.reloadData()
//            case .service:
//                resources = resourcesCollection["service"]!
//                self.tableView.reloadData()
//            case .education:
//                resources = resourcesCollection["education"]!
//                self.tableView.reloadData()
//            case .type:
//                resources = resourcesCollection["type"]!
//                self.tableView.reloadData()
//    //        default:
//    //            break
//            }
//        }
//}
//
//
//extension ResourcePageVC: UITextFieldDelegate, UIViewControllerTransitioningDelegate {
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(resources.count)
//        return resources.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let resource = resources[indexPath.row]
////        print(resource)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCell") as! ResourceCell
//        cell.setImage(resource: resource)
//        cell.minHeight = 80
//        print(cell)
//        return cell
//    }
//    
//    
//    //    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//    //        transition.isPresenting = true
//    //        return transition
//    //    }
//    //
//    //    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//    //        transition.isPresenting = false
//    //        self.tabBarController!.tabBar.items![0].isEnabled = true
//    //        self.tabBarController!.tabBar.items![1].isEnabled = true
//    //        self.tabBarController!.tabBar.items![3].isEnabled = true
//    //        return transition
//    //    }
//    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        let vc = HomePageSearchVC()
//        navigationController?.pushViewController(vc, animated: false)
//        navigationController?.viewWillAppear(true)
//        return false
//    }
//    
//    //    override func viewWillAppear(_ animated: Bool) {
//    //        super.viewWillAppear(animated)
//    //
//    ////        navigationController?.setNavigationBarHidden(false, animated: false)
//    //        navigationController?.isToolbarHidden = true
//    //    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let resourceURL = self.resources[indexPath.row]
//        
//        let webVC = WebViewController()
//        webVC.url = resourceURL.url
//        //        webVC.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(webVC, animated: true)
//    }
//}
