//
//  ArticleTitle.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit
import HandyJSON
import Moya
import SwiftyJSON
import Kingfisher

class ArticleTitle: UITableViewCell {
    // 头像
    var headImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 9
        return imageView
    }()
    
    // 名字
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    // 内容
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGBColor(60, 60, 60)
        label.numberOfLines = 3
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    // 底部
    var footerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = RGBColor(150, 150, 150)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var model: Answer? {
        didSet {
            guard let model = model else { return }
            let url = URL(string: model.author?.avatar_url ?? "")
            headImgView.kf.setImage(with: url, placeholder: UIImage(named: "UserGuestCenterBundle.bundle/Avatar_Liukanshan_Normal"))
            nameLabel.text = model.author?.name
            contentLabel.text = model.excerpt
        }
    }
}

