
//
//  DetailScrollView.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-04-03.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit

class DetailScrollView: UIScrollView {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = UIColor.darkGray
        return label
    }()
    
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(timeLabel)
        addSubview(imageView)
        addSubview(contentLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.width.equalTo(ScreenWidth - 20)
            make.left.equalToSuperview().offset(10)
        }
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(32)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.width.equalTo(ScreenWidth)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
             make.width.equalTo(ScreenWidth - 20)
            make.left.equalToSuperview().offset(10)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
