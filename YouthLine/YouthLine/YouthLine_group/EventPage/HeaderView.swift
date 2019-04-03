//
//  HeaderView.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import SnapKit
import UIKit

enum QuestionHeaderStyle {
    case list
    case detail
}

class HeaderView: UIView {
    typealias HeaderViewBlock = (Int) -> Void
    var actionBlock: HeaderViewBlock?
    
    var style: QuestionHeaderStyle = .detail {
        didSet {
            if style == .detail {}
        }
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
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
    

}
