//
//  ListBase.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//
import UIKit
import Alamofire
import HandyJSON
import MJRefresh
import SwiftyJSON
import DNSPageView

class ListBaseVC: BaseViewController {
    let BaseCellID = "BaseCell"
    let ImageCellID = "ImageCell"
    let BigImageCellID = "BigImageCell"
    
    let image_1 = UIImage(named: "book_dark")
    let image_2 = UIImage(named: "book")
    
    let image_3 = UIImage(named: "filterOff")
    let image_4 = UIImage(named: "filterOn")
    
    var ModelList: [EventModel]?
    var pageIndex: Int = 0
    var see_like = true
    
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 30, height: 10)
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        return label
    }()
    
    var headImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    var tableBackGroundView: UIImageView = {
        let tableBackGroundView = UIImageView(image: UIImage(named: "rainbow_7"))
        tableBackGroundView.contentMode = .scaleAspectFill
        tableBackGroundView.layer.masksToBounds = true
        return tableBackGroundView
    }()
    
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCellID)
        tableView.backgroundColor = UIColor.lightGray //格子背后的背景色
        tableView.backgroundView = tableBackGroundView
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    lazy var filterBtn: UIButton = {
        let filterBtn = UIButton.init(type: UIButtonType.system)
        filterBtn.frame = CGRect(x: 20, y: StatusBarHeight + 15, width: 25, height: 25)
        filterBtn.setTitle("See my likes", for: UIControlState.normal)
        filterBtn.setImage(UIImage(named: "book_dark"), for: UIControlState.normal)
        
        filterBtn.addTarget(self, action: #selector(seeLikeAction(button:)), for: UIControlEvents.touchUpInside)
        return filterBtn
    }()
    
    
    lazy var pageView: DNSPageView = {
        
        let style = DNSPageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = false
        style.isShowBottomLine = true
        style.titleViewBackgroundColor = UIColor.white
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = UIColor.black
        style.bottomLineHeight = 2
        
        let frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: ScreenHeight - NavigationBarHeight - 44)
        let pageView = DNSPageView(frame: frame,
                                   style: style,
                                   titles:[],
                                   childViewControllers: [],
                                   startIndex: 1)
        return pageView
    }()
    
    
    
    lazy var questionBtn: UIButton = {
        let questionBtn = UIButton.init(type: UIButtonType.system)
        questionBtn.frame = CGRect(x: ScreenWidth - 115, y: StatusBarHeight + 5, width: 110, height: 50)
        questionBtn.setTitle("", for: UIControlState.normal)
        questionBtn.setImage(UIImage(named: "filterOff"), for: UIControlState.normal)
        //        questionBtn.blueTheme()
        questionBtn.addTarget(self, action: #selector(seeLikeAction(button:)), for: UIControlEvents.touchUpInside)
        return questionBtn
    }()
    
    lazy var questionBtn_1: UIButton = {
        let questionBtn = UIButton.init(type: UIButtonType.system)
        questionBtn.frame = CGRect(x: ScreenWidth/2 - 50, y: StatusBarHeight + 10, width: 95, height: 30)
        questionBtn.setTitle("", for: UIControlState.normal)
        questionBtn.setImage(UIImage(named: "YouthLine_transparent"), for: UIControlState.normal)
        //        questionBtn.blueTheme()
        questionBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
        return questionBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(pageView)
        
        view.addSubview(questionBtn)
        view.addSubview(questionBtn_1)
        likeLabel.text = "Like Filter: off"
        view.addSubview(likeLabel)
        pageView.addSubview(tableView)
        //        view.addSubview(filterBtn)
        
        tableView.rowHeight = 150
        tableView.snp.makeConstraints { make in
            //make.top.equalTo(pageView.snp.bottom).offset(5)
            make.left.right.top.bottom.equalToSuperview()
        }
        
        tableView.initRefreshView()
        tableView.mj_header.refreshingBlock = { [weak self] in
            self?.pageIndex = 0
            self?.refreshDataSource()
        }
        tableView.mj_footer.refreshingBlock = { [weak self] in
            self?.refreshDataSource()
        }
        tableView.mj_header.beginRefreshing()
    }
    
    @objc func seeLikeAction(button: UIButton) {
        if see_like == false{
            ModelList = []
            filterBtn.setImage(image_1, for: .normal)
            questionBtn.setImage(image_3, for: .normal)
            refreshDataSource()
            see_like = true
        }
            
        else if see_like == true{
            ModelList = []
            filterBtn.setImage(image_2, for: .normal)
            questionBtn.setImage(image_4, for: .normal)
            let id = userID
            Alamofire.request("http://youthline-test-server.herokuapp.com/event_w_fav/" + String(id)).responseJSON { (responseObject) -> Void in
                
                let json = JSON(responseObject.result.value!)
                
                if let mappedObject_1 = JSONDeserializer<EventModel>.deserializeModelArrayFrom(json: json.description){
                    var noAdList: [EventModel] = []
                    for model in mappedObject_1 as! [EventModel] {
                        //                    if model.common_card != nil || model.fields != nil
                        if model.rid != nil {
                            if model.fav == "True"{
                                noAdList.append(model)
                            }
                        }
                        self.tableView.mj_header.endRefreshing()
                        self.tableView.mj_footer.endRefreshing()
                    }
                    if self.pageIndex == 0 {
                        self.ModelList = noAdList
                    } else {
                        self.ModelList = []
                        self.ModelList? += noAdList
                        //如果要连续刷就把上面两行改成self.ModelList? += noAdList
                    }
                    self.pageIndex += 1
                    self.tableView.reloadData()
                }
                
            }
            see_like = false
        }
    }
    
    func refreshDataSource() {
        let id = userID
        Alamofire.request("http://youthline-test-server.herokuapp.com/event_w_fav/" + String(id)).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            let json = JSON(responseObject.result.value!)
            
            if let mappedObject_1 = JSONDeserializer<EventModel>.deserializeModelArrayFrom(json: json.description){
                var noAdList: [EventModel] = []
                for model in mappedObject_1 as! [EventModel] {
                    //                    if model.common_card != nil || model.fields != nil
                    if model.rid != nil {
                        if self.see_like == true {
                            noAdList.append(model)
                        } else  if self.see_like == false{
                            if model.fav == "True"{
                                noAdList.append(model)
                            }
                        }
                    }
                    self.tableView.mj_header.endRefreshing()
                    self.tableView.mj_footer.endRefreshing()
                }
                if self.pageIndex == 0 {
                    self.ModelList = noAdList
                } else {
                    self.ModelList = []
                    self.ModelList? += noAdList
                    //如果要连续刷就把上面两行改成self.ModelList? += noAdList
                }
                self.pageIndex += 1
                self.tableView.reloadData()
            }
            
            
            
        }
    }
}


extension ListBaseVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ModelList?.count ?? 0
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
        let model = ModelList?[indexPath.section]
        if model?.rid != nil {
            let cell: BaseCell
            let content = (model?.b_content ?? "content not found")!
            if true {
                cell = tableView.dequeueReusableCell(withIdentifier: ImageCellID, for: indexPath) as! ImageCell
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: ImageCellID, for: indexPath) as! ImageCell
            }
            cell.model = model
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCellID, for: indexPath) as! ImageCell
            cell.model = model
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let model = ModelList?[indexPath.section]
        print("seansean111111", model?.fav == "True")
        if model?.rid != nil {
            let vc = ArticleDetailVC()
            vc.questionId = model?.rid ?? ""
            vc.questionTitle = model?.title ?? "title not found"
            vc.hidesBottomBarWhenPushed = true
            vc.question_content = model?.main_content ?? "content not found"
            vc.address = model?.address ?? "address not defined"
            vc.time = model?.event_time ?? "event time not defined"
            vc.website = model?.event_website ?? "event website not defined"
            vc.date = model?.event_date ?? "date not defined"
            vc.imageUrl = model?.image_url ?? "image not found"
            vc.fav = model?.fav ?? "False"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ListBaseVC {
    @objc func questionAction(button: UIButton) {
        print("hello it's me")
    }
    
}
