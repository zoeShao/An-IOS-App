//  EventBaseVC.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//
import DNSPageView
import UIKit


class EventBaseVC: BaseViewController {
    
    let viewControllers = [UIViewController(), ListBaseVC(), UIViewController(), UIViewController()]
    
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
        questionBtn.frame = CGRect(x: ScreenWidth - 85, y: StatusBarHeight + 10, width: 80, height: 30)
        questionBtn.setTitle("(- -)", for: UIControlState.normal)
        questionBtn.setImage(UIImage(named: "AskPost"), for: UIControlState.normal)
        questionBtn.blueTheme()
        questionBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
        return questionBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension EventBaseVC {
}

extension EventBaseVC {
    @objc func questionAction(button: UIButton) {
    }
}

extension EventBaseVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = EventSearchVC()
        navigationController?.pushViewController(vc, animated: false)
        return false
    }
}
