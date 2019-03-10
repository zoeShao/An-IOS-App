//
//  HomeEventCollectionViewCell.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import HandyJSON
import Moya
import SwiftyJSON
import UIKit

class HomeEventCollectionViewCell: UICollectionViewCell {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    

    var zhImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        contentView.addSubview(zhImageView)
        zhImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(contentView).offset(5)
            make.width.equalTo(frame.width - 10)
            make.height.equalTo(250)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.zhImageView.snp.bottom).offset(5)
            make.left.equalTo(contentView).offset(5)
            make.bottom.equalTo(contentView).offset(-5)
            make.right.equalToSuperview().offset(-5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: UpcomingEventModel? {
        didSet {
            titleLabel.text = model?.title?.panel_text
            let url = URL(string: (model?.image?.image_url)!)
            print("head:" + (model?.image?.image_url)!)
            if (model?.image?.image_url)! == "" {
                print("空")
            }
            self.zhImageView.kf.setImage(with: url)
        }
    }
}
