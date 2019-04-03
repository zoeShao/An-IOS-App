//
//  HomeDetailVC.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-10.
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

class HomeDetailVC: BaseViewController {
    var questionTitle: String = ""
    var questionTime: String = ""
    var questionImage: String = ""
    var questionContent: String = ""
    var index: Int = 0
    
    var contentRect = CGRect.zero
    
    let childrenVC =  [] as [UIViewController]
    let titles = [] as [String]
//    let image_1 = UIImage(named: "star_dark")
//    let image_2 = UIImage(named: "star")
//    var star_flag = 0
    
    
    let headerView: HomeDetailView = {
        let headerView = HomeDetailView()
        headerView.frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: ScreenHeight - NavigationBarHeight)
        return headerView
    }()
    
    
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
        
        let frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: ScreenHeight - NavigationBarHeight)
        let pageView = DNSPageView(frame: frame,
                                   style: style,
                                   titles: [],
                                   childViewControllers: [],
                                   startIndex: 0)
        return pageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.frame)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.addSubview(headerView)
        return scrollView
    }()
    
    var imgView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.width)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let contentView: HeaderView = {
        let view = HeaderView()
        view.frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: 300)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 300)
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "VAGRoundedStd-thin", size: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let item1 = UIBarButtonItem(customView: likeBtn)
//        self.navigationItem.rightBarButtonItem = item1
        self.view = scrollView
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        view.backgroundColor = BGColor
        
        headerView.titleLabel.text = questionTitle
        headerView.timeLabel.text = questionTime
        contentView.titleLabel.text = questionContent
        
        if questionImage != "" {
            let url = URL(string: questionImage)
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                let image = UIImage(data: imageData)
                imgView.image = image
            }
            view.addSubview(headerView)
            view.addSubview(imgView)
            view.addSubview(pageView)
            view.addSubview(contentView)
        } else {
            view.addSubview(headerView)
            view.addSubview(pageView)
            view.addSubview(contentView)
        }


        pageView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
        pageView.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(headerView.snp.bottom).offset(100)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(ScreenWidth - 100)
            print(Float(imgView.image?.size.width ?? 300), "width")
            print(imgView.image?.size.height ?? 50, "height")
            make.height.equalTo(200)
        }
        
        print(imgView.mj_size)
        
        pageView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(imgView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-10)
        }
    }
    //=================================
//    let searchField: UITextField = {
//        let field = UITextField()
//        field.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 30)
//        field.placeholder = "Search by key words"
//        field.textAlignment = .center
//        field.font = UIFont.systemFont(ofSize: 14)
//        field.borderStyle = .roundedRect
//        field.backgroundColor = BGColor
//        return field
//    }()
    
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 30)
//        label.textAlignment = .center
//        label.textColor = .black
//        return label
//    }()
//
//    lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView(frame: view.frame)
//        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
//        scrollView.delegate = self
//        scrollView.backgroundColor = UIColor.gray
//        scrollView.addSubview(headerView)
//        return scrollView
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.setNavigationBarHidden(false, animated: false)
//        navigationItem.titleView = searchField
//        view.backgroundColor = BGColor
//        headerView.titleLabel.text = questionTitle
//        headerView.timeLabel.text = "Posted on" + questionTime
//        headerView.contentLabel.text = questionContent
//        let url = URL.init(string: questionImage)
//        headerView.imageView.kf.setImage(with: url, placeholder: UIImage(named: "Default"))
//        view.addSubview(scrollView)
//        titleLabel.text = questionTitle
//    }
}


