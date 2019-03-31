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
        contentView.backgroundColor = UIColor.white
        contentLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-120)
        }
        
        contentView.addSubview(ImageView)
        ImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView).offset(-20)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var model: EventModel? {
        didSet {
            let url = URL(string: model?.image_url ?? "https://pic4.zhimg.com/v2-57025d3b940f9039d056632b1281ba77_400x224.jpeg")
            self.ImageView.kf.setImage(with: url)
        }
    }
}

