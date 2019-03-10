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
    var UpcomingEventModelList: [UpcomingEventModel]? = [event1]
    
    var pageIndex: Int = 0
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.itemSize = CGSize(width: view.frame.width, height: 300)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 60, width: ScreenWidth, height: 300), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(HomeEventCollectionViewCell.self, forCellWithReuseIdentifier: HomeEventCollectionViewCellID)
        collectionView.backgroundColor = UIColor.gray
        
        return collectionView
    }()
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.frame)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.white
        // add label
        let viewLable = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
        viewLable.textAlignment = NSTextAlignment.center
        viewLable.text = "Upcoming Events"
        viewLable.font =  UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        scrollView.addSubview(viewLable)
        // add collection view
        scrollView.addSubview(collectionView)
        // add news feed label
        let newsFeedLable = UILabel(frame: CGRect(x: 0, y: 360, width: ScreenWidth, height: 60))
        newsFeedLable.textAlignment = NSTextAlignment.center
        newsFeedLable.text = "News Feed"
        newsFeedLable.font =  UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        scrollView.addSubview(newsFeedLable)
        
        scrollView.addSubview(tableView)
        return scrollView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 420, width: ScreenWidth, height: view.frame.height), style: UITableViewStyle.grouped)
        
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
        return 10
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
        let vc = ArticleDetailVC()
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = UpcomingEventModelList?[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeEventCollectionViewCell", for: indexPath) as! HomeEventCollectionViewCell
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = UpcomingEventModelList?[indexPath.section]
        let vc = ArticleDetailVC()
        vc.questionTitle = model?.title?.panel_text ?? ""
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

