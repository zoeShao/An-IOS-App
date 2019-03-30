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

class HomeDetailVC: BaseViewController {
    var questionTitle: String = ""
    var questionTime: String = ""
    var questionImage: String = ""
    var questionContent: String = ""
    var answerIdList: [String]?
    var index: Int = 0
    
    let headerView: HomeDetailView = {
        let headerView = HomeDetailView()
        headerView.frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: ScreenHeight - NavigationBarHeight)
        return headerView
    }()
    
    let searchField: UITextField = {
        let field = UITextField()
        field.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 30)
        field.placeholder = "Search by key words"
        field.textAlignment = .center
        field.font = UIFont.systemFont(ofSize: 14)
        field.borderStyle = .roundedRect
        field.backgroundColor = BGColor
        return field
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 30)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.frame)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.gray
        scrollView.addSubview(headerView)
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.titleView = searchField
        view.backgroundColor = BGColor
        headerView.titleLabel.text = questionTitle
        headerView.timeLabel.text = "Posted on" + questionTime
        headerView.contentLabel.text = questionContent
        let url = URL.init(string: questionImage)
        headerView.imageView.kf.setImage(with: url, placeholder: UIImage(named: "Default"))
        view.addSubview(scrollView)
        titleLabel.text = questionTitle
    }
}

extension HomeDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 30 {
            searchField.alpha = 0
            if titleLabel.alpha == 0 {
                navigationItem.titleView = titleLabel
                UIView.animate(withDuration: 1) {
                    self.titleLabel.alpha = 1
                }
            }
        } else {
            titleLabel.alpha = 0
            if searchField.alpha == 0 {
                navigationItem.titleView = searchField
                UIView.animate(withDuration: 0.5) {
                    self.searchField.alpha = 1
                }
            }
        }
    }
}

