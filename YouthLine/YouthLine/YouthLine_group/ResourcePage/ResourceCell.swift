//
//  ResourceCell.swift
//  YouthLine
//
//  Created by Yuting Shao on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit

class ResourceCell: UITableViewCell {
    
    var ResourceTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight:UIFont.Weight.bold)
        label.numberOfLines = 0
        return label
    }()
    
    var footerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGBColor(150, 150, 150)
        return label
    }()
    
    var ResourceImgView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(ResourceTitleLabel)
        ResourceTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(15)
            make.top.equalTo(self.contentView).offset(12)
            make.right.equalToSuperview().offset(-120)
        }
        
        contentView.addSubview(footerLabel)
        footerLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(ResourceTitleLabel.snp.bottom).offset(10)
            make.right.equalTo(ResourceTitleLabel).offset(0)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(ResourceImgView)
        ResourceImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(65)
        }
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
    
    func setImage(resource: Resource) {
        ResourceImgView.image = resource.image
        ResourceTitleLabel.text = resource.title
    }
    
}
