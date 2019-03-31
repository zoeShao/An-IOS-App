//
//  Cell1.swift
//  ZhiHu
//
//  Created by NOKEYUAN on 2019-03-09.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit

class Cell1: UITableViewCell {
    
    
    
    @IBOutlet weak var resource: UILabel!
    
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
