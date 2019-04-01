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

class ListBaseVC: BaseViewController {
    let BaseCellID = "BaseCell"
    let ImageCellID = "ImageCell"
    let BigImageCellID = "BigImageCell"
    
    var ModelList: [EventModel]?
    var pageIndex: Int = 0
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        view.addSubview(tableView)
        tableView.rowHeight = 150
        tableView.snp.makeConstraints { make in
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
    
    func refreshDataSource() {
        Alamofire.request("http://youthline-test-server.herokuapp.com/event_w_fav/0").responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            let json = JSON(responseObject.result.value!)
            print(json["Events"], "hello")
            
            if let mappedObject_1 = JSONDeserializer<EventModel>.deserializeModelArrayFrom(json: json.description){
                print(mappedObject_1, "yesyesyes")
                var noAdList: [EventModel] = []
                for model in mappedObject_1 as! [EventModel] {
                    //                    if model.common_card != nil || model.fields != nil
                    if model.rid != nil {
                        noAdList.append(model)
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
//    }
//}

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
        //used to force refresh to update like data
//        tableView.initRefreshView()
//        tableView.mj_header.refreshingBlock = { [weak self] in
//            self?.pageIndex = 0
//            self?.refreshDataSource()
//            print("seansean")
//        }
//        tableView.mj_header.beginRefreshing()
//        
        // end of the enforcement
        
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
