//
//  ResourcePageVC.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit
import DNSPageView

class HomePageVC: BaseViewController {
    let titles = [] as [String]
    let viewControllers = [HomeListVC()]

    lazy var pageView: DNSPageView = {
        let style = DNSPageStyle()
        style.contentViewBackgroundColor = custom_menuBarPink
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
                                   titles: titles,
                                   childViewControllers: viewControllers,
                                   startIndex: 0)
        return pageView
    }()

//    lazy var searchTextField: UITextField = {
//        let textField = UITextField.init(frame: CGRect(x: 15, y: StatusBarHeight + 10, width: ScreenWidth - 100, height: 30))
//        textField.placeholder = "Enter any keywords you want"
//        textField.layer.masksToBounds = true
//        textField.layer.cornerRadius = 5
//        textField.textAlignment = NSTextAlignment.center
//        textField.backgroundColor = RGBColor(240, 240, 240)
//        textField.delegate = self
//        return textField
//    }()
//
//    lazy var questionBtn: UIButton = {
//        let questionBtn = UIButton.init(type: UIButtonType.system)
//        questionBtn.frame = CGRect(x: ScreenWidth - 85, y: StatusBarHeight + 10, width: 80, height: 30)
//        questionBtn.setTitle("", for: UIControlState.normal)
//        questionBtn.setImage(UIImage(named: "form"), for: UIControlState.normal)
//        questionBtn.blueTheme()
//        questionBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
//        return questionBtn
//    }()
    
    //加了三个lazy var, comment 掉了你两个lazy var, 分别是以前的搜索条和以前的图标按钮
    
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
        
        filterBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
        return filterBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = custom_menuBarPink //.white
        //initSearchBar()
        
        view.addSubview(questionBtn)
        view.addSubview(searchBtn)
        //view.addSubview(filterBtn)

        for vc in viewControllers {
            addChildViewController(vc)
        }
        view.addSubview(pageView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func initSearchBar() {
        //view.addSubview(searchTextField)
        view.addSubview(questionBtn)
    }

}

extension HomePageVC {
    @objc func questionAction(button: UIButton) {
    }
}

extension HomePageVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = HomePageSearchVC()
        navigationController?.pushViewController(vc, animated: false)
        return false
    }
}
