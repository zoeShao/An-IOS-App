//
//  ArticleDetailVC.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import HandyJSON
import MJRefresh
import Moya
import SnapKit
import SwiftMessages
import SwiftyJSON
import UIKit
import WebKit
import DNSPageView

class ArticleDetailVC: BaseViewController {
    var questionTitle: String = ""
    var questionId: String = ""
    var answerIdList: [String]?
    var index: Int = 0
    var question_content: String = ""
    var address: String = ""
    var time: String = ""
    var website: String = ""
    var imageUrl: String = ""
    var date: String = ""
    
    let childrenVC =  [] as [UIViewController]
    let titles = [] as [String]
    
    let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: 70)
        return headerView
    }()
    
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
        
        let frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: ScreenHeight - NavigationBarHeight)
        let pageView = DNSPageView(frame: frame,
                                   style: style,
                                   titles: [],
                                   childViewControllers: [],
                                   startIndex: 0)
        return pageView
    }()
    
    var imgView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 30)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 300)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        view.backgroundColor = BGColor
        
        headerView.titleLabel.text = questionTitle
        
        let url = URL(string: imageUrl)
        print(imageUrl, "hahaha")
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            imgView.image = image
        }
        
        contentLabel.text = question_content
        view.addSubview(headerView)
        view.addSubview(imgView)
        view.addSubview(pageView)
        
        pageView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
        pageView.addSubview(imgView)
        
        
    }
    
}
