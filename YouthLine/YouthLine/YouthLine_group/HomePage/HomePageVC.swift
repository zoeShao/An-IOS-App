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
        // 创建DNSPageStyle，设置样式
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
                                   titles: titles,
                                   childViewControllers: viewControllers,
                                   startIndex: 0)
        return pageView
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField.init(frame: CGRect(x: 15, y: StatusBarHeight + 10, width: ScreenWidth - 100, height: 30))
        //Mark:
        textField.placeholder = "Enter any keywords you want"
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.textAlignment = NSTextAlignment.center
        textField.backgroundColor = RGBColor(240, 240, 240)
        textField.delegate = self
        return textField
    }()
    
    //Mark: 换logo
    lazy var questionBtn: UIButton = {
        let questionBtn = UIButton.init(type: UIButtonType.system)
        questionBtn.frame = CGRect(x: ScreenWidth - 85, y: StatusBarHeight + 10, width: 80, height: 30)
        questionBtn.setTitle("提问", for: UIControlState.normal)
        questionBtn.setImage(UIImage(named: "ZHModuleColumnImage.bundle/Night_ZHAPP_Ask_Post"), for: UIControlState.normal)
        questionBtn.blueTheme()
        questionBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
        return questionBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 搜索栏
        initSearchBar()
        
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
        view.addSubview(searchTextField)
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
