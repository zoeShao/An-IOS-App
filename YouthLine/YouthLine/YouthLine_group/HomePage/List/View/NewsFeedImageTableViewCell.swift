//
//  NewsFeedImageTableViewCell.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit

class NewsFeedImageTableViewCell: NewsFeedBaseTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // 图片
    var zhImageView: UIImageView = {
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
        
        contentView.addSubview(zhImageView)
        zhImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var model: NewsFeedModel? {
        didSet {
            let content = (model?.news?.news_content ?? NewsContent())!
            let url = URL.init(string: (content.image?.image_url)!)
            
            print("head:" + (content.image?.image_url)!)
            if (content.image?.image_url)! == "" {
                print("空")
            }
            self.zhImageView.kf.setImage(with: url)
        }
    }
    
}
