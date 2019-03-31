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
//import MaterialComponents.MaterialPageControl

class HomeListVC: BaseViewController,UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource {
    let NewsFeedBaseTableViewCellID = "NewsFeedBaseTableViewCell"
    let NewsFeedImageTableViewCellID = "NewsFeedImageTableViewCell"
    let HomeEventCollectionViewCellID = "HomeEventCollectionViewCell"
    //    var fetchingMore = false
    var currentNewsIndex = 0
    // fixed size = 8
    var AllNewsFeedModelList: [NewsFeedModel]? = []
    // fixed size = 2
    var CurrentNewsFeedModelList: [NewsFeedModel]? = []
    // never changed
    var YouthlineIntroModelList: [YouthlineIntroModel]? = [event1, event2, event3]
    //    var pageIndex: Int = 0
    var galleryPageControl: UIPageControl = UIPageControl(frame: CGRect(x: ScreenWidth/2 - 15, y: 145, width: 30, height: 10))
    
    var timer:Timer!
    lazy var introScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 160))
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 1.0)
        
        //        scrollView.contentSize.height = 1.0 // disable vertical scroll
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.lightGray
        
        return scrollView
    }()
    
    
    
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
        tableView.rowHeight = 177.5
        
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
        //        scrollView.addSubview(collectionView)
        scrollView.addSubview(introScrollView)
        scrollView.addSubview(galleryPageControl)
        scrollView.addSubview(contactView())
        scrollView.addSubview(buttonView())
        //        scrollView.addSubview(tableView)
        scrollView.addSubview(tableUIView())
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        updateData()
        fetchData()
        print(AllNewsFeedModelList!.count)
        view.backgroundColor = UIColor.lightGray
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(2)
        }
        introDisplay()
        self.scrollView.bounces = false
        self.scrollView.isScrollEnabled = true
    }
    func fetchData(){
        Alamofire.request("http://youthline-test-server.herokuapp.com/home").responseJSON { (responseObject) -> Void in
            
            //            print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                print("fetchsuccess")
                if let mappedObject = JSONDeserializer<NewsFeedModel>.deserializeModelArrayFrom(json: resJson.description){
                    print("heyy")
                    for model in mappedObject as! [NewsFeedModel] {
                        // if model.common_card != nil || model.fields != nil
                        self.AllNewsFeedModelList!.append(model)
                        print("neic")
                    }
                    //                    print(self.AllNewsFeedModelList!.count)
                    if self.AllNewsFeedModelList!.count >= 2 {
                        self.CurrentNewsFeedModelList?.append(self.AllNewsFeedModelList![0])
                        self.CurrentNewsFeedModelList?.append(self.AllNewsFeedModelList![1])
                        print("buling")
                    } else if self.AllNewsFeedModelList!.count == 1{
                        self.CurrentNewsFeedModelList?.append(self.AllNewsFeedModelList![0])
                    }
                    self.tableView.reloadData()
                }
                
            }
            if responseObject.result.isFailure {
                let error : NSError = responseObject.result.error! as NSError
                print("news fetch failed")
            }
        }
    }
}




extension HomeListVC {
    func introDisplay(){   //实现图片滚动播放；
        //image width
        let imageW:CGFloat = self.introScrollView.frame.size.width;//获取ScrollView的宽作为图片的宽；
        let imageH:CGFloat = self.introScrollView.frame.size.height;//获取ScrollView的高作为图片的高；
        let imageY:CGFloat = 0;//图片的Y坐标就在ScrollView的顶端；
        let totalCount: NSInteger = 3;//轮播的图片数量；
        for index in 0..<totalCount{
            print(index)
            let imageView:UIImageView = UIImageView();
            let imageX:CGFloat = CGFloat(index) * imageW;
            imageView.frame = CGRect(x:imageX, y:imageY, width:imageW, height:imageH);//设置图片的大小，注意Image和ScrollView的关系，其实几张图片是按顺序从左向右依次放置在ScrollView中的，但是ScrollView在界面中显示的只是一张图片的大小，效果类似与画廊；
            let name:String = String(format: "HomePage%d", index+1);
            imageView.image = UIImage(named: name);
            print("image")
            self.introScrollView.showsHorizontalScrollIndicator = false;//不设置水平滚动条；
            self.introScrollView.addSubview(imageView);//把图片加入到ScrollView中去，实现轮播的效果；
            
        }
        
        //需要非常注意的是：ScrollView控件一定要设置contentSize;包括长和宽；
        let contentW:CGFloat = imageW * CGFloat(totalCount);//这里的宽度就是所有的图片宽度之和；
        self.introScrollView.contentSize = CGSize(width:contentW, height:0);
        self.introScrollView.isPagingEnabled = true;
        self.introScrollView.delegate = self;
        print(self.galleryPageControl)
        self.galleryPageControl.numberOfPages = totalCount;//下面的页码提示器；
        self.galleryPageControl.currentPageIndicatorTintColor = UIColor.lightGray
        //        self.galleryPageControl.addTarget(self, action: #selector(didChangePage(sender:)), for: .valueChanged)
        //        self.galleryPageControl.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        self.addTimer()
    }
    //
    //    func didChangePage(sender: MDCPageControl){
    //        var offset = scrollView.contentOffset
    //        offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width;
    //        scrollView.setContentOffset(offset, animated: true)
    //    }
    
    @objc func nextImage(sender:AnyObject!){//图片轮播；
        var page:Int = self.galleryPageControl.currentPage;
        print(page)
        if(page == 2){   //循环；
            page = 0;
            self.galleryPageControl.currentPage = 0
        }else{
            page = page + 1
            self.galleryPageControl.currentPage = page
        }
        
        let x:CGFloat = CGFloat(page) * self.introScrollView.frame.size.width;
        self.introScrollView.contentOffset = CGPoint(x:x, y:0);//注意：contentOffset就是设置ScrollView的偏移；
    }
    
    //    func scrollViewDidScroll(scrollView: UIScrollView) {
    //        //这里的代码是在ScrollView滚动后执行的操作，并不是执行ScrollView的代码；
    //        //这里只是为了设置下面的页码提示器；该操作是在图片滚动之后操作的；
    //        let scrollviewW:CGFloat = introScrollView.frame.size.width;
    //        let x:CGFloat = introScrollView.contentOffset.x;
    //        let page:Int = (Int)((x + scrollviewW / 2) / scrollviewW);
    //        self.galleryPageControl.currentPage = page;
    //    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollviewW:CGFloat = introScrollView.frame.size.width;
        let x:CGFloat = introScrollView.contentOffset.x;
        let page:Int = (Int)((x + scrollviewW / 2) / scrollviewW);
        self.galleryPageControl.currentPage = page;
        //        self.galleryPageControl.scrollViewDidScroll(scrollView)
    }
    
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        self.galleryPageControl.scrollViewDidEndDecelerating(scrollView)
    //    }
    //
    //    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    //        self.galleryPageControl.scrollViewDidEndScrollingAnimation(scrollView)
    //    }
    
    func addTimer(){   //图片轮播的定时器；
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(nextImage(sender:)), userInfo: nil, repeats: true);
    }
    
}
