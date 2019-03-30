//
//  ResourceBaseVC.swift
//  YouthLine
//
//  Created by Yuting Shao on 2019-03-29.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import DNSPageView
import UIKit


class ResourceBaseVC: BaseViewController {
    let transition = SlideInTransition()
    
    let viewControllers = [UIViewController(), ResourcePageVC(), UIViewController(), UIViewController()]
    
    lazy var pageView: DNSPageView = {
        
        let style = DNSPageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = false
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = UIColor.black
        style.bottomLineHeight = 2
        
        let frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: ScreenHeight - NavigationBarHeight - 44)
        let pageView = DNSPageView(frame: frame,
                                   style: style,
                                   titles:[],
                                   childViewControllers: viewControllers,
                                   startIndex: 1)
        return pageView
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField.init(frame: CGRect(x: 15, y: StatusBarHeight + 10, width: ScreenWidth - 100, height: 30))
        textField.placeholder = "Enter search texts here"
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.textAlignment = NSTextAlignment.center
        textField.backgroundColor = RGBColor(240, 240, 240)
        textField.delegate = self
        return textField
    }()
    
    lazy var questionBtn: UIButton = {
        let questionBtn = UIButton.init(type: UIButtonType.system)
        questionBtn.frame = CGRect(x: ScreenWidth/2 - 50, y: StatusBarHeight + 10, width: 95, height: 30)
        questionBtn.setTitle("", for: UIControlState.normal)
        questionBtn.setImage(UIImage(named: "YouthLine_transparent"), for: UIControlState.normal)
        //        questionBtn.blueTheme()
        questionBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
        return questionBtn
    }()
    
    lazy var searchBtn: UIButton = {
        let searchBtn = UIButton.init(type: UIButtonType.system)
        searchBtn.frame = CGRect(x: ScreenWidth - 50, y: StatusBarHeight + 13, width: 25, height: 25)
        searchBtn.setTitle("", for: UIControlState.normal)
        searchBtn.setImage(UIImage(named: "search"), for: UIControlState.normal)
        
        searchBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
        return searchBtn
    }()
    
    lazy var filterBtn: UIButton = {
        let filterBtn = UIButton.init(type: UIButtonType.system)
        filterBtn.frame = CGRect(x: 20, y: StatusBarHeight + 15, width: 25, height: 25)
        filterBtn.setTitle("", for: UIControlState.normal)
        filterBtn.setImage(UIImage(named: "slider"), for: UIControlState.normal)
        
        filterBtn.addTarget(self, action: #selector(tapFilter(sender:)), for: UIControlEvents.touchUpInside)
        return filterBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.addSubview(searchTextField)
        view.addSubview(questionBtn)
        view.addSubview(searchBtn)
        view.addSubview(filterBtn)
        
        for vc in viewControllers {
            addChildViewController(vc)
        }
        view.addSubview(pageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.isToolbarHidden = true
    }
    
    @objc func tapFilter(sender: UIBarButtonItem) {
//        let ResourcePageVC: ResourcePageVC = ResourcePageVC()
        let menuViewController: MenuViewController = MenuViewController()
        ResourcePageVC().didTapFilter(menuViewController: MenuViewController())
        menuViewController.didTapMenuTypte = { menuType in
//            print(menuType)
            switch menuType {
            case .all:
                menuSelected = "all"
            case .settlement:
               menuSelected = "settlement"
            case .faith:
               menuSelected = "faith"
            case .sex:
                menuSelected = "sex"
            case .forms:
                menuSelected = "forms"
            case .service:
               menuSelected = "service"
            case .education:
                menuSelected = "education"
            case .type:
                menuSelected = "type"
                //        default:
                //            break
            }
//            ResourcePageVC().transitionToNew(menuType)
            ResourcePageVC().tableView.reloadData()
            self.viewDidLoad()
            self.viewWillAppear(true)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
        self.tabBarController!.tabBar.items![0].isEnabled = false
        self.tabBarController!.tabBar.items![1].isEnabled = false
        self.tabBarController!.tabBar.items![3].isEnabled = false
    }
    
    func initSearchBar() {
        view.addSubview(searchTextField)
        view.addSubview(questionBtn)
    }
}

extension ResourceBaseVC {
}

extension ResourceBaseVC {
    @objc func questionAction(button: UIButton) {
    }
}

extension ResourceBaseVC: UITextFieldDelegate, UIViewControllerTransitioningDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = HomePageSearchVC()
        navigationController?.pushViewController(vc, animated: false)
        return false
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
}

