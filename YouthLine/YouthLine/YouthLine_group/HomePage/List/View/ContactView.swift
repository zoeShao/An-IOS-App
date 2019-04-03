//
//  ContactView.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-04-02.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit
import MessageUI

class ContactView: UIView {
    var callButton = UIButton.init(type: UIButtonType.custom) as UIButton
    var messageButton = UIButton.init(type: UIButtonType.custom) as UIButton
    var contactLabel = UILabel()
    
    func call(button: UIButton) {
        let title = "1-800-268-9688"
        let iconName = "call"
        button.backgroundColor = UIColor(red: 0.93, green: 0.80, blue: 0.80, alpha: 1)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setImage(UIImage(named: iconName), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layoutIfNeeded()
    }
    
    func message(button: UIButton){
        let title = "647-694-4275"
        let iconName = "message"
        button.backgroundColor = UIColor(red: 0.93, green: 0.80, blue: 0.80, alpha: 1)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setImage(UIImage(named: iconName), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layoutIfNeeded()
    }
    
    func contact(label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Feel free to contact us!"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        call(button: callButton)
        message(button: messageButton)
        contact(label: contactLabel)
        backgroundColor = UIColor.white
        addSubview(contactLabel)
        addSubview(callButton)
        addSubview(messageButton)
        
        let imageWidth = callButton.imageView!.frame.width
        let textWidth = (callButton.currentTitle! as NSString).size(withAttributes:[NSAttributedStringKey.font:callButton.titleLabel!.font!]).width
        let width = textWidth + imageWidth + 40
        
        let mimageWidth = messageButton.imageView!.frame.width
        let mtextWidth = (messageButton.currentTitle! as NSString).size(withAttributes:[NSAttributedStringKey.font:messageButton.titleLabel!.font!]).width
        let mwidth = mtextWidth + mimageWidth + 40
        
        callButton.snp.makeConstraints { make in
            make.top.equalTo(contactLabel.snp.bottom)
            make.left.equalToSuperview().offset((ScreenWidth - width - mwidth)/3)
            make.width.equalTo(width)
            make.height.equalTo(30)
        }
        
        messageButton.snp.makeConstraints { make in
            make.top.equalTo(contactLabel.snp.bottom)
            make.right.equalToSuperview().offset(-(ScreenWidth - width - mwidth)/3)
            make.width.equalTo(width)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

