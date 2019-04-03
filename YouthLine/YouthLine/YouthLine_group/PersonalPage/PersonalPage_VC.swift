//
//  PersonalPage_VC.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-31.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit
import DNSPageView
class PersonalPage_VC: BaseViewController {
    let titles = [] as [String]
    let viewControllers = [PersonalPageVC()]
    
    lazy var pageView: DNSPageView = {
        let style = DNSPageStyle()
        style.contentViewBackgroundColor = .white
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
    
    lazy var questionBtn: UIButton = {
        let questionBtn = UIButton.init(type: UIButtonType.system)
        questionBtn.frame = CGRect(x: ScreenWidth/2 - 50, y: StatusBarHeight + 10, width: 95, height: 30)
        questionBtn.setTitle("", for: UIControlState.normal)
        questionBtn.setImage(UIImage(named: "YouthLine_transparent"), for: UIControlState.normal)
        questionBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
        return questionBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = custom_menuBarPink //.white
        
        view.addSubview(questionBtn)
        
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

extension PersonalPage_VC {
    @objc func questionAction(button: UIButton) {
    }
}

extension PersonalPage_VC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = HomePageSearchVC()
        navigationController?.pushViewController(vc, animated: false)
        return false
    }
}
