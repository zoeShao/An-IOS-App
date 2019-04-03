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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        view.backgroundColor = BGColor
        
        let homeScrollView = DetailScrollView()
        homeScrollView.titleLabel.text = questionTitle
        
        let tline = Int(((questionTitle as NSString).size(withAttributes:[NSAttributedStringKey.font:homeScrollView.titleLabel.font!]).width) / (ScreenWidth))
        
        let titleH = (homeScrollView.titleLabel.text! as NSString).size(withAttributes:[NSAttributedStringKey.font:homeScrollView.titleLabel.font!]).height * CGFloat(tline)
        homeScrollView.timeLabel.text = questionTime
        
        let timeH = (homeScrollView.timeLabel.text! as NSString).size(withAttributes:[NSAttributedStringKey.font:homeScrollView.timeLabel.font!]).height
        var imageH =  CGFloat(0)
        if questionImage != "" {
            let url = URL(string: questionImage)
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                let image = UIImage(data: imageData)
                homeScrollView.imageView.image = image
                imageH = image!.size.height
            }
        }
        homeScrollView.contentLabel.text = questionContent
        let cline = Int(((questionContent as NSString).size(withAttributes:[NSAttributedStringKey.font:homeScrollView.contentLabel.font!]).width) / (ScreenWidth))
        let contentH = (homeScrollView.contentLabel.text! as NSString).size(withAttributes:[NSAttributedStringKey.font:homeScrollView.contentLabel.font!]).height * CGFloat(cline)
        let height = titleH + timeH + imageH + contentH + 100
        homeScrollView.contentSize = CGSize(width:ScreenWidth, height: height)
        self.view = homeScrollView
    }
}
