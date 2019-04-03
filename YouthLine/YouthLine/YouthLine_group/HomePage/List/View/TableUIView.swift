//
//  TableView.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-04-02.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit

class TableUIView: UIView {
    var changeNewsButton = UIButton.init(type: UIButtonType.custom) as UIButton
    var tableView = UITableView()
    
    lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "VAGRoundedStd-thin", size: 14)
        label.numberOfLines = 1
        label.textColor = UIColor.darkGray
        label.text = "Check out our news below!"
        return label
    }()
    
    func changeNewsButton(button: UIButton) {
        let title = "Next"
        let iconName = "refresh"
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 10)
        button.setImage(UIImage(named: iconName), for: .normal)
        button.layoutIfNeeded()
    }
    
    func createTableView(tableView: UITableView) {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.isScrollEnabled = false
        tableView.bounces = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(newsLabel)
        changeNewsButton(button: changeNewsButton)
        addSubview(changeNewsButton)
        createTableView(tableView: tableView)
        addSubview(tableView)
        
        newsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(15)
        }
        
        let imageWidth = changeNewsButton.imageView!.frame.width
        let textWidth = (changeNewsButton.currentTitle! as NSString).size(withAttributes:[NSAttributedStringKey.font:changeNewsButton.titleLabel!.font!]).width
        let width = textWidth + imageWidth + 24
        
        changeNewsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(ScreenWidth - width - 20)
            make.width.equalTo(width)
            make.height.equalTo(15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(newsLabel.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
