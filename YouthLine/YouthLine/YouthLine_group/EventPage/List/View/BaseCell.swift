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
        label.font = UIFont.init(name: "VAGRoundedStd-thin", size: 18)
        label.numberOfLines = 2
        label.textColor = UIColor.black
        return label
    }()
    
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "VAGRoundedStd-light", size: 14)
        label.textColor = RGBColor(80, 80, 80)
        label.numberOfLines = 8
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
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 8
        
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
            make.top.equalTo(titleLabel.snp.bottom).offset(15); //8
            make.left.equalTo(contentView).offset(14)
            make.width.height.equalTo(25)
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)// 34
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
    
    var model: EventModel? {
        didSet {
            titleLabel.text = model?.title
            let address = "address: " + String(model?.address ?? "address: unknown")
            let time = "time: " + String(model?.event_time ?? "time: unknown")
            let date = model?.event_date ?? "date: unknown"
            let b_content = model?.b_content ?? "no content displayed"
            contentLabel.text = (time + "\n" + address + "\n\n" + b_content)
            headImgLabel.text = model?.source
            
            let reasonType = model?.source
            if reasonType == "ins" {
                headImgView.image = UIImage(named: "ins")
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

