//
//  HomePageScrollView.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-04-02.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit

class HomePageUIView: UIView {
    var contactView = ContactView()
    var buttonView = ButtonView()
    var tableUIView = TableUIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentSize = CGSize(width: frame.width, height: 1.0)
//        delegate = self
        backgroundColor = UIColor.lightGray
//        addSubview(introScrollView)
//        addSubview(galleryPageControl)
        addSubview(contactView)
        addSubview(buttonView)
        addSubview(tableUIView)
        
        contactView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(ScreenWidth)
        }
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(contactView.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(90)
        }
        
        tableUIView.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.bottom.equalToSuperview()
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
