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
    
    var ModelList: [Model]?
    var pageIndex: Int = 0
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCellID)
        
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        view.addSubview(tableView)
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
                
                
                if true{
                    var noAdList: [Model] = []
                    for model in mappedObject as! [Model] {
                        if model.common_card != nil || model.fields != nil {
                            noAdList.append(model)
                        }
                        self.tableView.mj_header.endRefreshing()
                        self.tableView.mj_footer.endRefreshing()
                    }
                    if self.pageIndex == 0 {
                        self.ModelList = noAdList
                    } else {
                        self.ModelList? += noAdList
                    }
                    self.pageIndex += 1
                    self.tableView.reloadData()
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
        if model?.common_card != nil {
            let cell: BaseCell
            let content = (model?.common_card?.feed_content ?? Feed_content())!
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
        if model?.common_card != nil {
            let vc = ArticleDetailVC()
            vc.answerId = model?.extra?.id
            vc.questionTitle = "data not yet prepared"
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
