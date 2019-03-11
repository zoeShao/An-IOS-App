//
//  ImageCell.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit

class ImageCell: BaseCell {
    
    var ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-120)
        }
        
        contentView.addSubview(ImageView)
        ImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var model: Model? {
        didSet {
            let content = (model?.common_card?.feed_content ?? Feed_content())!
            let url = URL(string: imageUrl[count])
            self.ImageView.kf.setImage(with: url)
            count += 1
            if count > 4 {count = 0}
        }
    }
}

