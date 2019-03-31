//
//  ResourceBaseVC.swift
//  YouthLine
//
//  Created by Yuting Shao on 2019-03-30.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
import MJRefresh
import SwiftyJSON

class ResourceBaseVC: BaseViewController {
    let transition = SlideInTransition()
    var resources: [Resource] = []
    
    var tableBackGroundView: UIImageView = {
        let tableBackGroundView = UIImageView(image: UIImage(named: "rainbow_3"))
        tableBackGroundView.contentMode = .scaleAspectFill
        tableBackGroundView.layer.masksToBounds = true
        return tableBackGroundView
    }()
    
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
    
    lazy var questionBtn: UIButton = {
        let questionBtn = UIButton.init(type: UIButtonType.system)
        questionBtn.frame = CGRect(x: ScreenWidth/2 - 50, y: StatusBarHeight + 10, width: 95, height: 30)
        questionBtn.setTitle("", for: UIControlState.normal)
        questionBtn.setImage(UIImage(named: "YouthLine_transparent"), for: UIControlState.normal)
        //        questionBtn.blueTheme()
        //        questionBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
        return questionBtn
    }()
    
    lazy var searchBtn: UIButton = {
        let searchBtn = UIButton.init(type: UIButtonType.system)
        searchBtn.frame = CGRect(x: ScreenWidth - 50, y: StatusBarHeight + 13, width: 25, height: 25)
        searchBtn.setTitle("", for: UIControlState.normal)
        searchBtn.setImage(UIImage(named: "search"), for: UIControlState.normal)
        
        //        searchBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
        return searchBtn
    }()
    
    lazy var filterBtn: UIButton = {
        let filterBtn = UIButton.init(type: UIButtonType.system)
        filterBtn.frame = CGRect(x: 20, y: StatusBarHeight + 15, width: 25, height: 25)
        filterBtn.setTitle("", for: UIControlState.normal)
        filterBtn.setImage(UIImage(named: "slider"), for: UIControlState.normal)
        
        filterBtn.addTarget(self, action: #selector(didTapFilter(sender:)), for: UIControlEvents.touchUpInside)
        return filterBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: ScreenHeight - NavigationBarHeight - 44), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.lightGray //The background colour behind the cell
        tableView.backgroundView = tableBackGroundView
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(ResourceCell.self, forCellReuseIdentifier: "ResourceCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        hello()
        //        if let resourcesCollectionAll = loadResource() {
        //            print(resourcesCollectionAll)
        //        } else {
        //            print(123)
        //        }
        view.backgroundColor = UIColor.white
        view.addSubview(questionBtn)
        view.addSubview(searchBtn)
        view.addSubview(filterBtn)
        view.addSubview(tableView)
        //        resourcesCollection = createDic()
        fetchData()
        //        resources = resourcesCollection["all"]!
        //        self.tableView.reloadData()
        
        
    }
    
    @objc func didTapFilter(sender: UIBarButtonItem) {
        let menuViewController: MenuViewController = MenuViewController()
        menuViewController.didTapMenuTypte = { menuType in
            //            print(menuType)
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
        case .favourite:
            resources = resourcesCollection["favourite"]!
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
        case .forms:
            resources = resourcesCollection["forms"]!
            self.tableView.reloadData()
        case .service:
            resources = resourcesCollection["service"]!
            self.tableView.reloadData()
        case .education:
            resources = resourcesCollection["education"]!
            self.tableView.reloadData()
        case .type:
            resources = resourcesCollection["type"]!
            self.tableView.reloadData()
        case .health:
            resources = resourcesCollection["health"]!
            self.tableView.reloadData()
        case .parents:
            resources = resourcesCollection["parents"]!
            self.tableView.reloadData()
        case .gender:
            resources = resourcesCollection["gender"]!
            self.tableView.reloadData()
        case .selfcare:
            resources = resourcesCollection["selfcare"]!
            self.tableView.reloadData()
        case .homelessness:
            resources = resourcesCollection["homelessness"]!
            self.tableView.reloadData()
        case .trans:
            resources = resourcesCollection["trans"]!
            self.tableView.reloadData()
        case .school:
            resources = resourcesCollection["school"]!
            self.tableView.reloadData()
        case .comingout:
            resources = resourcesCollection["comingout"]!
            self.tableView.reloadData()
        case .emergency:
            resources = resourcesCollection["emergency"]!
            self.tableView.reloadData()
        case .community:
            resources = resourcesCollection["community"]!
            self.tableView.reloadData()
        case .selfharm:
            resources = resourcesCollection["selfharm"]!
            self.tableView.reloadData()
        case .bullying:
            resources = resourcesCollection["bullying"]!
            self.tableView.reloadData()
        }
    }
    
}


extension ResourceBaseVC: UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return ModelList?.count ?? 0
    //    }
    
    func fetchData() {
        let url = "http://youthline-test-server.herokuapp.com/resources"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                //            print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        print("example success")
                        //to get JSON return value
                        if let result = response.result.value {
                            //                        let JSON = result as! NSDictionary
                            let json = JSON(result)
                            for i in 0..<json["Resources"].count {
                                if let categoryName = json["Resources"][i]["category"].string {
                                    print(categoryName)
                                    for j in 0..<json["Resources"][i]["contents"].count {
                                        
                                        let resourceTitle = json["Resources"][i]["contents"][j]["title"].string!
                                        let resourceURL = json["Resources"][i]["contents"][j]["resource_url"].string!
                                        let imageURL = json["Resources"][i]["contents"][j]["img"].string!
                                        print(resourceTitle)
                                        print(resourceURL)
                                        print(imageURL)
                                        let resource = Resource(image: imageURL, title: resourceTitle, url: URL(string: resourceURL)!)
                                        resourcesCollection["all"]!.append(resource)
                                        resourcesCollection[categoryName]!.append(resource)
                                    }
                                    
                                } else {
                                    //Print the error
                                    print("error, wrong key")
                                }
                            }
                            self.resources = resourcesCollection["all"]!
                            self.tableView.reloadData()
                            //                        print(json)
                        }
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //            //to get JSON return value
                //            if let result = response.result.value {
                //                let JSON = result as! NSDictionary
                //                print(JSON)
                //            }
        }
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = HomePageSearchVC()
        navigationController?.pushViewController(vc, animated: false)
        navigationController?.viewWillAppear(true)
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 0.01
    //    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        return nil
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resource = resources[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCell") as! ResourceCell
        cell.setImage(resource: resource)
        cell.minHeight = 80
        cell.contentView.backgroundColor = UIColor.clear
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.isToolbarHidden = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resourceURL = self.resources[indexPath.row]
        
        let webVC = WebViewController()
        webVC.url = resourceURL.url
        //        webVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
