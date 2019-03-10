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

class BaseCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 2
        return label
    }()
    
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGBColor(80, 80, 80)
        label.numberOfLines = 3
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    
    var headImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 9
        return imageView
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(12)
            make.right.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8);
            make.left.equalTo(contentView).offset(14)
            make.width.height.equalTo(18)
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(34)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-35)
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
                        let catPictureURL = URL(string: "https://pic1.zhimg.com//v2-8b80f4c6e3565a13c2de68b7c5235453_s.jpg")
                        self.headImgView.kf.setImage(with: catPictureURL, placeholder: UIImage(named: "UserGuestCenterBundle.bundle/Avatar_Liukanshan_Normal"))
                    }
               }
            }

