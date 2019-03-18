//
//  BaseCell.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import HandyJSON
import Moya
import SwiftyJSON
import UIKit
import QuartzCore

class BaseCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "VAGRoundedStd-thin", size: 16)
        label.numberOfLines = 2
        label.textColor = UIColor.black
        return label
    }()
    
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "VAGRoundedStd-light", size: 12)
        label.textColor = RGBColor(80, 80, 80)
        label.numberOfLines = 4
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    
    var headImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    var headImgLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9)
        label.textColor = RGBColor(80, 80, 80)
        label.numberOfLines = 1

        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
//        contentView.alpha = 1
        contentView.backgroundColor = UIColor.clear
        contentView.layer.cornerRadius = 250
        
//        
//        contentView.addSubview(headImgLabel)
//        headImgLabel.snp.makeConstraints {make in
//              make.width.equalTo(150)
//              make.height.equalTo(10)
//
//              make.left.equalTo(contentView).offset(15)
//
//        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(12)
            make.right.equalToSuperview().offset(-15)

        }
        
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8); //8
            make.left.equalTo(contentView).offset(14)
            make.width.height.equalTo(18)
}
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(headImgView.snp.bottom).offset(5)// 34
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(contentView.snp.left).offset(5)
//            make.right.equalToSuperview().offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var model: Model? {
        didSet {
            titleLabel.text = model?.common_card?.feed_content?.title?.panel_text
            contentLabel.text = model?.common_card?.feed_content?.content?.panel_text
            headImgLabel.text = "posted on FaceBook, 10:00 a.m."
            
            let reasonType = model?.uninterest_reasons?.last?.reason_type
            if reasonType == "creator" {
                token = model?.uninterest_reasons?.last?.object_token
            } else {
                headImgView.image = UIImage(named: "UserGuestCenterBundle.bundle/Avatar_Liukanshan_Normal")
            }
        }
    }
    
    var token: String? {
        didSet {
            
                        let catPictureURL = URL(string: iconUrl[count_1])
                        count_1 += 1
                        if count_1 > 4 {count_1 = 0}
            
                        self.headImgView.kf.setImage(with: catPictureURL, placeholder: UIImage(named: "UserGuestCenterBundle.bundle/Avatar_Liukanshan_Normal"))
                    }
               }
            }

