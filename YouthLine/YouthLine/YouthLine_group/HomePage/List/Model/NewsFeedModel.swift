//
//  NewsFeedModel.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//


import Foundation
import HandyJSON

struct NewsFeedModel: HandyJSON {
    var title: String?
    var time: String?
    var news_content: String?
    var image: String?
}
