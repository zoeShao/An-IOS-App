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

public let NewsFeedBaseTableViewCellID = "NewsFeedBaseTableViewCell"
public let NewsFeedImageTableViewCellID = "NewsFeedImageTableViewCell"
public let HomeEventCollectionViewCellID = "HomeEventCollectionViewCell"

class HomeListVC: BaseViewController,UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource {
    var AllNewsFeedModelList: [NewsFeedModel]? = []
    var CurrentNewsFeedModelList: [NewsFeedModel]? = []
    var YouthlineIntroModelList: [YouthlineIntroModel]? = [event1, event2, event3]
    var galleryPageControl: UIPageControl = UIPageControl(frame: CGRect(x: ScreenWidth/2 - 15, y: 145, width: 30, height: 10))
    var currentNewsIndex = 0
    
    public var timer:Timer!
    lazy var introScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 160))
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 1.0)
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.lightGray
        return scrollView
    }()
    
    var homePageUIView = HomePageUIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        updateData()
        fetchData()
        print(AllNewsFeedModelList!.count)
        view.backgroundColor = UIColor.lightGray
        view.addSubview(introScrollView)
        view.addSubview(galleryPageControl)
        view.addSubview(homePageUIView)
        homePageUIView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(introScrollView.snp.bottom)
        }
        homePageUIView.contactView.callButton.addTarget(self, action: #selector(makePhoneCall(sender:)), for: .touchUpInside)
        homePageUIView.contactView.messageButton.addTarget(self, action: #selector(sendMessage(sender:)), for: .touchUpInside)
        homePageUIView.tableUIView.tableView.delegate = self
        homePageUIView.tableUIView.tableView.dataSource = self
        homePageUIView.tableUIView.tableView.register(NewsFeedBaseTableViewCell.self, forCellReuseIdentifier: NewsFeedBaseTableViewCellID)
        homePageUIView.tableUIView.tableView.register(NewsFeedImageTableViewCell.self, forCellReuseIdentifier: NewsFeedImageTableViewCellID)
        homePageUIView.tableUIView.changeNewsButton.addTarget(self, action: #selector(nextNews(sender:)), for: .touchUpInside)
        introDisplay()
    }
    
    func fetchData(){
        Alamofire.request("http://youthline-test-server.herokuapp.com/home").responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                if let mappedObject = JSONDeserializer<NewsFeedModel>.deserializeModelArrayFrom(json: resJson.description){
                    for model in mappedObject as! [NewsFeedModel] {
                        self.AllNewsFeedModelList!.append(model)
                    }
                    if self.AllNewsFeedModelList!.count >= 2 {
                        self.CurrentNewsFeedModelList?.append(self.AllNewsFeedModelList![0])
                        self.CurrentNewsFeedModelList?.append(self.AllNewsFeedModelList![1])
                    } else if self.AllNewsFeedModelList!.count == 1{
                        self.CurrentNewsFeedModelList?.append(self.AllNewsFeedModelList![0])
                    }
                    self.homePageUIView.tableUIView.tableView.reloadData()
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
    func introDisplay(){
        // Generate all the introduction images
        // use scrollview width/height as image width/height
        let imageW = self.introScrollView.frame.size.width
        let imageH = self.introScrollView.frame.size.height
        let imageY:CGFloat = 0
        // total number of images to show
        let totalCount: NSInteger = 3
        // put images in orders in the scroll view
        for index in 0..<totalCount{
            let imageX:CGFloat = CGFloat(index) * imageW
            let imageView = UIImageView(frame: CGRect(x:imageX, y:imageY, width:imageW, height:imageH))
            // get the images from Assets with names
            imageView.image = UIImage(named: String(format: "HomePage%d", index+1));
            self.introScrollView.showsHorizontalScrollIndicator = false
            self.introScrollView.addSubview(imageView)
        }
        // set scroll view content width = sum of width of all images to show
        let contentW = imageW * CGFloat(totalCount)
        self.introScrollView.contentSize = CGSize(width:contentW, height:0)
        self.introScrollView.isPagingEnabled = true
        self.introScrollView.delegate = self
        // set up page indicator for the scroll view
        self.galleryPageControl.numberOfPages = totalCount
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
    
    @objc func nextImage(sender:AnyObject!){
        var page:Int = self.galleryPageControl.currentPage;
        if(page == 2){
            page = 0;
            self.galleryPageControl.currentPage = 0
        }else{
            page = page + 1
            self.galleryPageControl.currentPage = page
        }
        let x = CGFloat(page) * self.introScrollView.frame.size.width
        // move to the next image
        self.introScrollView.contentOffset = CGPoint(x:x, y:0)
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
        let scrollviewW:CGFloat = introScrollView.frame.size.width
        let x = introScrollView.contentOffset.x;
        let page:Int = (Int)((x + scrollviewW / 2) / scrollviewW)
        self.galleryPageControl.currentPage = page
        //        self.galleryPageControl.scrollViewDidScroll(scrollView)
    }
    
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        self.galleryPageControl.scrollViewDidEndDecelerating(scrollView)
    //    }
    //
    //    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    //        self.galleryPageControl.scrollViewDidEndScrollingAnimation(scrollView)
    //    }
    
    func addTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(nextImage(sender:)), userInfo: nil, repeats: true);
    }
    
}
