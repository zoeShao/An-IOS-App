//
//  HomeListVC.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//
// new
import UIKit
import Alamofire
import HandyJSON
import MJRefresh
import SwiftyJSON
import MessageUI

class HomeListVC: BaseViewController {
    let NewsFeedBaseTableViewCellID = "NewsFeedBaseTableViewCell"
    let NewsFeedImageTableViewCellID = "NewsFeedImageTableViewCell"
    let HomeEventCollectionViewCellID = "HomeEventCollectionViewCell"
    var fetchingMore = false
    var currentNewsIndex = 0
    // fixed size = 8
    var AllNewsFeedModelList: [NewsFeedModel]? = []
    // fixed size = 2
    var CurrentNewsFeedModelList: [NewsFeedModel]? = []
    // never changed
    var YouthlineIntroModelList: [YouthlineIntroModel]? = [event1, event2, event3]
    
    //    var pageIndex: Int = 0
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 160)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 160), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeEventCollectionViewCell.self, forCellWithReuseIdentifier: HomeEventCollectionViewCellID)
        collectionView.backgroundColor = UIColor.gray
        return collectionView
    }()
    
    func contactView() -> UIView {
        let contactView = UIView.init()
        contactView.frame = CGRect(x: 0, y: 160, width: ScreenWidth, height: 60)
        contactView.backgroundColor = UIColor.white
        contactView.addSubview(contactLabel)
        contactView.addSubview(callButton)
        contactView.addSubview(messageButton())
        return contactView
    }
    
    func buttonView() -> UIView {
        let buttonView = UIView.init()
        buttonView.frame = CGRect(x: 0, y: 220, width: ScreenWidth, height: 80)
        buttonView.backgroundColor = UIColor.white
        buttonView.addSubview(buttonLabel)
        buttonView.addSubview(insButton)
        buttonView.addSubview(twitterButton)
        buttonView.addSubview(fbButton)
        buttonView.addSubview(youtbButton)
        buttonView.addSubview(tumblrButton)
        return buttonView
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 50, width: ScreenWidth, height: view.frame.height - NavigationBarHeight), style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsFeedBaseTableViewCell.self, forCellReuseIdentifier: NewsFeedBaseTableViewCellID)
        tableView.register(NewsFeedImageTableViewCell.self, forCellReuseIdentifier: NewsFeedImageTableViewCellID)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.isScrollEnabled = false
        tableView.bounces = true
        
        return tableView
    }()
    
    func tableUIView() -> UIView {
        let tableUIView = UIView.init()
        tableUIView.frame = CGRect(x: 0, y: 300, width: ScreenWidth, height: view.frame.height)
        tableUIView.backgroundColor = UIColor.white
        tableUIView.addSubview(newsLabel)
        tableUIView.addSubview(changeNewsButton())
        tableUIView.addSubview(tableView)
        return tableUIView
    }
    
    func changeNewsButton() -> UIButton{
        let title = "Next"
        let iconName = "refresh"
        let button = UIButton.init(type: UIButtonType.custom) as UIButton
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.setImage(UIImage(named: iconName), for: .normal)
        button.addTarget(self, action: #selector(nextNews(sender:)), for: .touchUpInside)
        let imageWidth = button.imageView!.frame.width
        let textWidth = (title as NSString).size(withAttributes:[NSAttributedStringKey.font:button.titleLabel!.font!]).width
        let width = textWidth + imageWidth + 24
        button.frame = CGRect(x: ScreenWidth - 60, y: 30, width: width, height: 20)
        button.layoutIfNeeded()
        return button
    }
    
    lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 30, width: ScreenWidth, height: 20)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.numberOfLines = 1
        label.textColor = UIColor.darkGray
        label.text = "Check out our news below!"
        return label
    }()
    
    lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 20)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Check out our socialmedias!"
        return label
    }()
    
    lazy var insButton: UIButton = {
        let insButton = UIButton.init(type: UIButtonType.custom) as UIButton
        insButton.frame = CGRect(x: 20, y: 20, width: 60, height: 60)
        insButton.setImage(UIImage(named: "Instagram"), for: UIControlState.normal)
        insButton.addTarget(self, action: #selector(openInstagram(sender:)), for: .touchUpInside)
        return insButton
    }()
    
    lazy var twitterButton: UIButton = {
        let twitterButton = UIButton.init(type: UIButtonType.custom) as UIButton
        twitterButton.frame = CGRect(x: 100, y: 20, width: 60, height: 60)
        twitterButton.setImage(UIImage(named: "Twitter"), for: UIControlState.normal)
        twitterButton.addTarget(self, action: #selector(openTwitter(sender:)), for: .touchUpInside)
        return twitterButton
    }()
    
    lazy var fbButton: UIButton = {
        let fbButton = UIButton.init(type: UIButtonType.custom) as UIButton
        fbButton.frame = CGRect(x: 180, y: 20, width: 60, height: 60)
        fbButton.setImage(UIImage(named: "Facebook"), for: UIControlState.normal)
        fbButton.addTarget(self, action: #selector(openFacebook(sender:)), for: .touchUpInside)
        return fbButton
    }()
    
    lazy var youtbButton: UIButton = {
        let youtbButton = UIButton.init(type: UIButtonType.custom) as UIButton
        youtbButton.frame = CGRect(x: 260, y: 20, width: 60, height: 60)
        youtbButton.setImage(UIImage(named: "Youtube"), for: UIControlState.normal)
        youtbButton.addTarget(self, action: #selector(openYoutube(sender:)), for: .touchUpInside)
        return youtbButton
    }()
    
    lazy var tumblrButton: UIButton = {
        let tumblrButton = UIButton.init(type: UIButtonType.custom) as UIButton
        tumblrButton.frame = CGRect(x: 340, y: 20, width: 60, height: 60)
        tumblrButton.setImage(UIImage(named: "Tumblr"), for: UIControlState.normal)
        tumblrButton.addTarget(self, action: #selector(openTumblr(sender:)), for: .touchUpInside)
        return tumblrButton
    }()
    
    lazy var callButton: UIButton = {
        let title = "1-800-268-9688"
        let iconName = "call"
        let button = UIButton.init(type: UIButtonType.custom) as UIButton
        button.backgroundColor = UIColor(red: 0.93, green: 0.80, blue: 0.80, alpha: 1)
        button.setTitle(title, for: .normal)
        //        button.setTitle(title, for: .highlighted)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        //        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setImage(UIImage(named: iconName), for: .normal)
        button.addTarget(self, action: #selector(makePhoneCall(sender:)), for: .touchUpInside)
        //        button.setImage(UIImage(named: iconName), for: .highlighted)
        let imageWidth = button.imageView!.frame.width
        let textWidth = (title as NSString).size(withAttributes:[NSAttributedStringKey.font:button.titleLabel!.font!]).width
        let width = textWidth + imageWidth + 40
        //24 - the sum of your insets from left and right
        //        widthConstraints.constant = width
        button.frame = CGRect(x: 60, y: 25, width: width, height: 30)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layoutIfNeeded()
        return button
    }()
    
    func messageButton() -> UIButton{
        let title = "647-694-4275"
        let iconName = "message"
        let button = UIButton.init(type: UIButtonType.custom) as UIButton
        button.backgroundColor = UIColor(red: 0.93, green: 0.80, blue: 0.80, alpha: 1)
        button.setTitle(title, for: .normal)
        //        button.setTitle(title, for: .highlighted)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        //        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setImage(UIImage(named: iconName), for: .normal)
        button.addTarget(self, action: #selector(sendMessage(sender:)), for: .touchUpInside)
        //        button.setImage(UIImage(named: iconName), for: .highlighted)
        let imageWidth = button.imageView!.frame.width
        let textWidth = (title as NSString).size(withAttributes:[NSAttributedStringKey.font:button.titleLabel!.font!]).width
        let width = textWidth + imageWidth + 40
        button.frame = CGRect(x: 240, y: 25, width: width, height: 30)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layoutIfNeeded()
        return button
    }
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 20)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Feel free to contact us!"
        return label
    }()
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.frame)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 1.0)
        
        //        scrollView.contentSize.height = 1.0 // disable vertical scroll
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.lightGray
        scrollView.addSubview(collectionView)
        scrollView.addSubview(contactView())
        scrollView.addSubview(buttonView())
        //        scrollView.addSubview(tableView)
        scrollView.addSubview(tableUIView())
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let news1 = test() {
            //            CurrentNewsFeedModelList?.append(news1)
            AllNewsFeedModelList?.append(news1)
            AllNewsFeedModelList?.append(news1)
        } else {
            CurrentNewsFeedModelList = []
            AllNewsFeedModelList = []
        }
        if let news2 = test1() {
            //            CurrentNewsFeedModelList?.append(news2)
            AllNewsFeedModelList?.append(news2)
            AllNewsFeedModelList?.append(news2)
        } else {
            CurrentNewsFeedModelList = []
            AllNewsFeedModelList = []
        }
        CurrentNewsFeedModelList?.append(AllNewsFeedModelList![0])
        CurrentNewsFeedModelList?.append(AllNewsFeedModelList![1])
        view.backgroundColor = UIColor.lightGray
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(2)
        }
        self.scrollView.bounces = false
        self.scrollView.isScrollEnabled = true
        
    }
}

extension HomeListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CurrentNewsFeedModelList?.count ?? 0
        //        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
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
        let model = CurrentNewsFeedModelList?[indexPath.section]
        let cell: NewsFeedBaseTableViewCell
        if model?.image != nil {
            cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedImageTableViewCellID, for: indexPath) as! NewsFeedImageTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedBaseTableViewCellID, for: indexPath) as! NewsFeedBaseTableViewCell
        }
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = CurrentNewsFeedModelList?[indexPath.section]
        let vc = HomeDetailVC()
        vc.questionTitle = model?.title ?? ""
        vc.questionTime = model?.time ?? ""
        vc.questionImage = model?.image ?? ""
        vc.questionContent = model?.news_content ?? ""
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//extension HomeListVC: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        if scrollView == self.scrollView {
//            tableView.isScrollEnabled = (self.scrollView.contentOffset.y >= 200)
//        }
//
//        if scrollView == self.tableView {
//            self.tableView.isScrollEnabled = (tableView.contentOffset.y > 0)
//        }
//    }
//
//    func beginBatchFetch() {
//        fetchingMore = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 , execute: {
//            let newItems = self.NewsFeedModelList!
//            self.NewsFeedModelList?.append(contentsOf: newItems)
//            self.fetchingMore = false
//            self.tableView.reloadData()
//        })
//    }
//}

extension HomeListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return YouthlineIntroModelList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = YouthlineIntroModelList?[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeEventCollectionViewCell", for: indexPath) as! HomeEventCollectionViewCell
        cell.model = model
        return cell
    }
}

extension HomeListVC:  MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        //        composeVC.recipients = ["6476944275"]
        composeVC.recipients = ["6479396177"]
        composeVC.body = "Enter texting messages here:"
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }
}

extension HomeListVC {
    @objc func openInstagram(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "instagram://user?username=lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.instagram.com/lgbtyouthline/")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openTwitter(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "twitter://user?screen_name=LGBTYouthLine")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://twitter.com/LGBTYouthLine")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openFacebook(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "fb://profile")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.facebook.com/lgbtyouthline")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openYoutube(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "youtube://www.youtube.com/user/lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.youtube.com/user/lgbtyouthline")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openTumblr(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "tumblr://x-callback-url/blog?blogName=lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "http://lgbtyouthline.tumblr.com")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func makePhoneCall(sender: UIButton) {
        //18002689688
        guard let number = URL(string: "tel://" + "+18002689688") else { return }
        if (UIApplication.shared.canOpenURL(number)) {
            // Open Instagram application
            UIApplication.shared.open(number)
        } else {
            print("phone call not available")
        }
    }
    
    @objc func sendMessage(sender: UIButton) {
        displayMessageInterface()
    }
    
    @objc func nextNews(sender: UIButton) {
        print("update news")
        currentNewsIndex = currentNewsIndex + 2
        if currentNewsIndex == AllNewsFeedModelList!.count {
            currentNewsIndex = 0
        }
        print(currentNewsIndex)
        CurrentNewsFeedModelList?.removeAll()
        CurrentNewsFeedModelList?.append(AllNewsFeedModelList![currentNewsIndex])
        CurrentNewsFeedModelList?.append(AllNewsFeedModelList![currentNewsIndex+1])
        self.tableView.reloadData()
    }
}
