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
    
    var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        contentView.addSubview(eventImageView)
        eventImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(5)
            make.width.equalTo(frame.width)
            make.height.equalTo(150)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: YouthlineIntroModel? {
        didSet {
            let url = (model?.image)!
            print("head:" + (model?.image)!)
            if (model?.image)! == "" {
                print("empty")
            }
            self.eventImageView.image = UIImage(named: url)
        }
    }
}
