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
    // 标题
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 2
        return label
    }()
    
    // 内容
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGBColor(80, 80, 80)
        label.numberOfLines = 3
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    // 头像
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
            make.top.equalTo(titleLabel.snp.bottom).offset(8); //.snp.bottom).offset(8)
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
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    var model: Model? {
//        didSet {
//            titleLabel.text = model?.common_card?.feed_content?.title?.panel_text
//            contentLabel.text = model?.common_card?.feed_content?.content?.panel_text
//            //            footerLabel.text = model?.common_card?.footline?.elements?[0].text?.panel_text
//            
//            let reasonType = model?.uninterest_reasons?.last?.reason_type
//            if reasonType == "creator" {
//                token = model?.uninterest_reasons?.last?.object_token
//            } else {
//                headImgView.image = UIImage(named: "UserGuestCenterBundle.bundle/Avatar_Liukanshan_Normal")
//            }
//        }
//    }
//    
//    var token: String? {
////        didSet {
////
////            ListProvider.request(.memberProfile(token!)) { result in
////                if case let .success(response) = result {
////                    
////                    let data = try? response.mapJSON()
////                    let json = JSON(data!)
////
////                    print(json)
////                    if let member = JSONDeserializer<ZHMember>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
////                        //                        self.nameLabel.text = member.name
////                        //                        self.profileLabel.text = member.headline!
////                        let url = URL(string: member.avatar_url!)
////                        self.headImgView.kf.setImage(with: url, placeholder: UIImage(named: "UserGuestCenterBundle.bundle/Avatar_Liukanshan_Normal"))
////                    }
////                } else {
////                    print("")
////                }
////            }
////        }
//    }
}
