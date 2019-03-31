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

class ArticleDetailVC: BaseViewController {
    var questionTitle: String = ""
    var questionId: String = ""
    var answerIdList: [String]?
    var index: Int = 0
    
    var answerId: String? {
        didSet {
            
            let urlString = "https://www.zhihu.com/appview/v2/answer/" + answerId!
            let contentURL = URL(string: urlString)
            var request = URLRequest(url: contentURL!)
            request.allHTTPHeaderFields = Headers
            
        }
    }
    
    
    let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: 70)
        return headerView
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 30)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    @objc func writeAnswerClick() {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        view.backgroundColor = BGColor
        
        headerView.titleLabel.text = questionTitle
        titleLabel.text = questionTitle
        view.addSubview(headerView)
        headerView.actionBlock = { [unowned self] (btnIndex: Int) in
            if btnIndex == 0 {
                self.writeAnswerClick()
            }
        }
        
    }
    
}
