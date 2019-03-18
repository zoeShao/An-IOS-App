//
//  HomeListVC.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
import MJRefresh
import SwiftyJSON

class HomeListVC: BaseViewController {
    let NewsFeedBaseTableViewCellID = "NewsFeedBaseTableViewCell"
    let NewsFeedImageTableViewCellID = "NewsFeedImageTableViewCell"
    let HomeEventCollectionViewCellID = "HomeEventCollectionViewCell"
    
    var NewsFeedModelList: [NewsFeedModel]? = [newsModel1, newsModel2]
    var UpcomingEventModelList: [UpcomingEventModel]? = [event1, event2]
    
    var pageIndex: Int = 0
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 300)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 300), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeEventCollectionViewCell.self, forCellWithReuseIdentifier: HomeEventCollectionViewCellID)
        collectionView.backgroundColor = UIColor.gray
        
        return collectionView
    }()

    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 380, width: ScreenWidth, height: view.frame.height), style: UITableViewStyle.grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsFeedBaseTableViewCell.self, forCellReuseIdentifier: NewsFeedBaseTableViewCellID)
        tableView.register(NewsFeedImageTableViewCell.self, forCellReuseIdentifier: NewsFeedImageTableViewCellID)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.backgroundColor = UIColor.lightGray
        tableView.isScrollEnabled = false
        tableView.bounces = true
        return tableView
    }()
    
    lazy var insButton: UIButton = {
        let insButton = UIButton.init(type: UIButtonType.custom) as UIButton
        insButton.frame = CGRect(x: 20, y: 310, width: 60, height: 60)
        insButton.setImage(UIImage(named: "Instagram"), for: UIControlState.normal)
        insButton.addTarget(self, action: #selector(openInstagram(sender:)), for: .touchUpInside)
        return insButton
    }()

    lazy var twitterButton: UIButton = {
        let twitterButton = UIButton.init(type: UIButtonType.custom) as UIButton
        twitterButton.frame = CGRect(x: 100, y: 310, width: 60, height: 60)
        twitterButton.setImage(UIImage(named: "Twitter"), for: UIControlState.normal)
        twitterButton.addTarget(self, action: #selector(openTwitter(sender:)), for: .touchUpInside)
        return twitterButton
    }()
    
    lazy var fbButton: UIButton = {
        let fbButton = UIButton.init(type: UIButtonType.custom) as UIButton
        fbButton.frame = CGRect(x: 180, y: 310, width: 60, height: 60)
        fbButton.setImage(UIImage(named: "Facebook"), for: UIControlState.normal)
        fbButton.addTarget(self, action: #selector(openFacebook(sender:)), for: .touchUpInside)
        return fbButton
    }()
    
    lazy var youtbButton: UIButton = {
        let youtbButton = UIButton.init(type: UIButtonType.custom) as UIButton
        youtbButton.frame = CGRect(x: 260, y: 310, width: 60, height: 60)
        youtbButton.setImage(UIImage(named: "Youtube"), for: UIControlState.normal)
        youtbButton.addTarget(self, action: #selector(openYoutube(sender:)), for: .touchUpInside)
        return youtbButton
    }()
    
    lazy var tumblrButton: UIButton = {
        let tumblrButton = UIButton.init(type: UIButtonType.custom) as UIButton
        tumblrButton.frame = CGRect(x: 340, y: 310, width: 60, height: 60)
        tumblrButton.setImage(UIImage(named: "Tumblr"), for: UIControlState.normal)
        tumblrButton.addTarget(self, action: #selector(openTumblr(sender:)), for: .touchUpInside)
        return tumblrButton
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.frame)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.white
        scrollView.addSubview(collectionView)
        scrollView.addSubview(insButton)
        scrollView.addSubview(twitterButton)
        scrollView.addSubview(fbButton)
        scrollView.addSubview(youtbButton)
        scrollView.addSubview(tumblrButton)
        scrollView.addSubview(tableView)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        //no need to write following if checked in storyboard
        self.scrollView.bounces = false
        self.scrollView.isScrollEnabled = true
    }
}

extension HomeListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return NewsFeedModelList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = NewsFeedModelList?[indexPath.section]
        let cell: NewsFeedBaseTableViewCell
        let content = (model?.news?.news_content ?? NewsContent())!
        if content.image != nil {
            cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedImageTableViewCellID, for: indexPath) as! NewsFeedImageTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedBaseTableViewCellID, for: indexPath) as! NewsFeedBaseTableViewCell
        }
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = NewsFeedModelList?[indexPath.section]
        let vc = HomeDetailVC()
        vc.questionTitle = model?.news?.news_content?.title?.panel_text ?? ""
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension HomeListVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            tableView.isScrollEnabled = (self.scrollView.contentOffset.y >= 200)
        }
        
        if scrollView == self.tableView {
            self.tableView.isScrollEnabled = (tableView.contentOffset.y > 0)
        }
    }
}

extension HomeListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return UpcomingEventModelList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = UpcomingEventModelList?[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeEventCollectionViewCell", for: indexPath) as! HomeEventCollectionViewCell
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = UpcomingEventModelList?[indexPath.section]
        let vc = HomeDetailVC()
        vc.questionTitle = model?.title?.panel_text ?? ""
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeListVC {
    @objc func openInstagram(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "instagram://user?username=lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.instagram.com/lgbtyouthline/")! // Replace the link by your instagram weblink

        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.openURL(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.openURL(instWB as URL)
        }
    }
    
    @objc func openTwitter(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "twitter://user?screen_name=LGBTYouthLine")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://twitter.com/LGBTYouthLine")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.openURL(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.openURL(instWB as URL)
        }
    }
    
    @objc func openFacebook(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "fb://profile")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.facebook.com/lgbtyouthline")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.openURL(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.openURL(instWB as URL)
        }
    }
    
    @objc func openYoutube(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "youtube://www.youtube.com/user/lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.youtube.com/user/lgbtyouthline")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.openURL(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.openURL(instWB as URL)
        }
    }
    
    @objc func openTumblr(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "tumblr://x-callback-url/blog?blogName=lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "http://lgbtyouthline.tumblr.com")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.openURL(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.openURL(instWB as URL)
        }
    }
}
