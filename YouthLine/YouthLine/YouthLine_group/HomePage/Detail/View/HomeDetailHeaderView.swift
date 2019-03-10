//
//  HomeDetailHeaderView.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//


import SnapKit
import UIKit

class HomeDetailHeaderView: UIView {
    typealias HeaderViewBlock = (Int) -> Void
    var actionBlock: HeaderViewBlock?
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-12)
        }
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func seeAllAnswers(_ sender: UIButton) {
        actionBlock?(sender.tag)
    }
}

