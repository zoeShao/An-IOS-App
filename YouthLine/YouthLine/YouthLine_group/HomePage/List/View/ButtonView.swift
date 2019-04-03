//
//  ButtonView.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-04-02.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit

class ButtonView: UIView {
//    var buttonLabel = UILabel()
//    var insButton = UIButton.init(type: UIButtonType.custom) as UIButton
//    var twitterButton = UIButton.init(type: UIButtonType.custom) as UIButton
//    var fbButton = UIButton.init(type: UIButtonType.custom) as UIButton
//    var youtbButton = UIButton.init(type: UIButtonType.custom) as UIButton
//    var tumblrButton = UIButton.init(type: UIButtonType.custom) as UIButton

    
    lazy var insButton: UIButton = {
        let insButton = UIButton.init(type: UIButtonType.custom) as UIButton
//        insButton.frame = CGRect(x: 20, y: 20, width: 60, height: 60)
        insButton.setImage(UIImage(named: "Instagram"), for: UIControlState.normal)
        insButton.addTarget(self, action: #selector(openInstagram(sender:)), for: .touchUpInside)
        return insButton
    }()
    
    lazy var twitterButton: UIButton = {
        let twitterButton = UIButton.init(type: UIButtonType.custom) as UIButton
//        twitterButton.frame = CGRect(x: 100, y: 20, width: 60, height: 60)
        twitterButton.setImage(UIImage(named: "Twitter"), for: UIControlState.normal)
        twitterButton.addTarget(self, action: #selector(openTwitter(sender:)), for: .touchUpInside)
        return twitterButton
    }()
    
    lazy var fbButton: UIButton = {
        let fbButton = UIButton.init(type: UIButtonType.custom) as UIButton
//        fbButton.frame = CGRect(x: 180, y: 20, width: 60, height: 60)
        fbButton.setImage(UIImage(named: "Facebook"), for: UIControlState.normal)
        fbButton.addTarget(self, action: #selector(openFacebook(sender:)), for: .touchUpInside)
        return fbButton
    }()
    
    lazy var youtbButton: UIButton = {
        let youtbButton = UIButton.init(type: UIButtonType.custom) as UIButton
//        youtbButton.frame = CGRect(x: 260, y: 20, width: 60, height: 60)
        youtbButton.setImage(UIImage(named: "Youtube"), for: UIControlState.normal)
        youtbButton.addTarget(self, action: #selector(openYoutube(sender:)), for: .touchUpInside)
        return youtbButton
    }()
    
    lazy var tumblrButton: UIButton = {
        let tumblrButton = UIButton.init(type: UIButtonType.custom) as UIButton
//        tumblrButton.frame = CGRect(x: 340, y: 20, width: 60, height: 60)
        tumblrButton.setImage(UIImage(named: "Tumblr"), for: UIControlState.normal)
        tumblrButton.addTarget(self, action: #selector(openTumblr(sender:)), for: .touchUpInside)
        return tumblrButton
    }()
    
    lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 30)
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Check out our socialmedias!"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(buttonLabel)
        addSubview(insButton)
        addSubview(twitterButton)
        addSubview(fbButton)
        addSubview(youtbButton)
        addSubview(tumblrButton)
        
        let width = 60
        let space = (ScreenWidth - (60 * 5)) / 6
        
        insButton.snp.makeConstraints { make in
            make.top.equalTo(buttonLabel.snp.bottom)
            make.left.equalToSuperview().offset(space)
            make.width.equalTo(width)
            make.height.equalTo(width)
        }
        twitterButton.snp.makeConstraints { make in
            make.top.equalTo(buttonLabel.snp.bottom)
            make.left.equalTo(insButton.snp.right).offset(space)
            make.width.equalTo(width)
            make.height.equalTo(width)
        }
        fbButton.snp.makeConstraints { make in
            make.top.equalTo(buttonLabel.snp.bottom)
            make.left.equalTo(twitterButton.snp.right).offset(space)
            make.width.equalTo(width)
            make.height.equalTo(width)
        }
        youtbButton.snp.makeConstraints { make in
            make.top.equalTo(buttonLabel.snp.bottom)
            make.left.equalTo(fbButton.snp.right).offset(space)
            make.width.equalTo(width)
            make.height.equalTo(width)
        }
        tumblrButton.snp.makeConstraints { make in
            make.top.equalTo(buttonLabel.snp.bottom)
            make.left.equalTo(youtbButton.snp.right).offset(space)
            make.right.equalToSuperview().offset(-space)
            make.width.equalTo(width)
            make.height.equalTo(width)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension ButtonView {
    @objc func openInstagram(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "instagram://user?username=lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.instagram.com/lgbtyouthline/")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openTwitter(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "twitter://user?screen_name=LGBTYouthLine")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://twitter.com/LGBTYouthLine")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openFacebook(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "fb://profile")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.facebook.com/lgbtyouthline")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openYoutube(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "youtube://www.youtube.com/user/lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.youtube.com/user/lgbtyouthline")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openTumblr(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "tumblr://x-callback-url/blog?blogName=lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "http://lgbtyouthline.tumblr.com")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
}
