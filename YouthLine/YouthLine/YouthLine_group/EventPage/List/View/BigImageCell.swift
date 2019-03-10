//
//  BigImageCell.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit

class BigImageCell: BaseCell {
    
    var ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(ImageView)
        ImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
            make.height.equalTo(120)
        }
        
        contentLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(ImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-35)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override var model: Model? {
//        didSet {
//            let market = (model?.fields ?? MarketCard())!
//            self.titleLabel.text = market.body?.title ?? ""
//            self.contentLabel.text = market.body?.description
//            let url = URL.init(string: (market.body?.image)!)
//            self.ImageView.kf.setImage(with: url)
//        }
//    }
}

