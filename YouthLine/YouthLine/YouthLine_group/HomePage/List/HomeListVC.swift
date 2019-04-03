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
    // fixed size = 2
    var CurrentNewsFeedModelList: [NewsFeedModel]? = []
    // never changed
    var YouthlineIntroModelList: [YouthlineIntroModel]? = [event1, event2, event3]
    //    var fetchingMore = false
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
