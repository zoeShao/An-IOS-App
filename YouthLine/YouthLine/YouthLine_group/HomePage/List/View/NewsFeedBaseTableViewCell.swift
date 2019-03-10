//
//  NewsFeedBaseTableViewCell.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//


import HandyJSON
import Moya
import SwiftyJSON
import UIKit

class NewsFeedBaseTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // 标题?
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 2
        return label
    }()
    
    // 内容
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGBColor(80, 80, 80)
        label.numberOfLines = 8
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
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
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(12)
            make.right.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleLabel)
            make.width.height.equalTo(18)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(headImgView)
            make.left.equalTo(headImgView.snp.right).offset(6)
        }
        nameLabel.setContentHuggingPriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(headImgView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var model: NewsFeedModel? {
        didSet {
            titleLabel.text = model?.news?.news_content?.title?.panel_text
            contentLabel.text = model?.news?.news_content?.content?.panel_text
            //            let url = URL(string: (model?.news?.type)!)
            //            headImgView.kf.setImage(with: url, placeholder: UIImage(named: "UserGuestCenterBundle.bundle/Avatar_Liukanshan_Normal"))
            
            headImgView.image = UIImage(named: (model?.news?.type)!)
            nameLabel.text = model?.news?.type
        }
    }
    
    
}

