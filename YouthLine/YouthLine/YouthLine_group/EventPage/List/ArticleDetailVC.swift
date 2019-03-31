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
    var fav: String = ""
    
    
    var contentRect = CGRect.zero
    
    let childrenVC =  [] as [UIViewController]
    let titles = [] as [String]
    let image_1 = UIImage(named: "star_dark")
    let image_2 = UIImage(named: "star")
    var star_flag = 0
    
    //let scrollView = UIScrollView(frame: UIScreen.mainScreen.bounds)
    
    let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: 70)
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
    
    
    lazy var likeBtn: UIButton = {
        let likeBtn = UIButton.init(type: UIButtonType.system)
        likeBtn.frame = CGRect(x: ScreenWidth - 50, y: StatusBarHeight + 13, width: 25, height: 25)
        likeBtn.setTitle("", for: UIControlState.normal)
        var image = image_2
        print(fav, "try and see")
        if fav == "True" {
            image = image_2
            star_flag = 1
        } else {
            image = image_1
            star_flag = 0
        }
        likeBtn.setImage(image, for: .normal)
        likeBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
        return likeBtn
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
        let item1 = UIBarButtonItem(customView: likeBtn)
        self.navigationItem.rightBarButtonItem = item1
        self.view = scrollView
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        view.backgroundColor = BGColor
        
        headerView.titleLabel.text = questionTitle
        
        
        contentView.titleLabel.text = question_content
        
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            imgView.image = image
        }
        
        view.addSubview(headerView)
        view.addSubview(imgView)
        view.addSubview(pageView)
        view.addSubview(contentView)
        
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
        
//        for view in scrollView.subviews {
//            contentRect = contentRect.union(view.frame)
//        }
//
//        scrollView.contentSize = contentRect.size
    }
    
}

extension ArticleDetailVC {
    @objc func questionAction(button: UIButton) {
        if star_flag == 0{
            submitAction(uid: "0", rid: questionId, action: "POST")
            likeBtn.setImage(image_2, for: .normal)
            star_flag = 1
        } else if star_flag == 1{
            print("change")
            submitAction(uid: "0", rid: questionId, action: "DELETE")
            likeBtn.setImage(image_1, for: .normal)
            star_flag = 0
        }
    }
}

func submitAction(uid: String, rid: String, action: String) {
    
    let parameters = ["uid": uid, "rid": rid]
    let url = URL(string: "http://youthline-test-server.herokuapp.com/event_w_fav/")!
    let session = URLSession.shared
    
    var request = URLRequest(url: url)
    request.httpMethod = action
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        
        guard error == nil else {
            return
        }
        
        guard let data = data else {
            return
        }
        
        do {
            //create json object from data
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                print(json, "response received")
                // handle json...
                
            }
        } catch let error {
            print(error.localizedDescription)
        }
    })
    task.resume()
}
