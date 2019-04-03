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
            make.right.equalToSuperview().offset(-140)
        }
        
        contentView.addSubview(ImageView)
        ImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView).offset(-25)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(120)
            make.height.equalTo(84)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var model: EventModel? {
        didSet {
            let url = URL(string: model?.image_url ?? "https://3.bp.blogspot.com/-1IoBgxlbNBs/WZnchQWxd4I/AAAAAAABJsY/pHJAN762VJsX_F-xHJ8Ro2fR4EKG8FeDACKgBGAs/s1600/doraemon_nobita3.png")
            self.ImageView.kf.setImage(with: url)
        }
    }
}

