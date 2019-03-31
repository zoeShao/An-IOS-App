//
//  UpcomingEventModel.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import Foundation
import HandyJSON

struct YouthlineIntroModel: HandyJSON {
    var image: String?
}

var event1 = YouthlineIntroModel(image: "HomePage1")
var event2 = YouthlineIntroModel(image: "HomePage2")
var event3 = YouthlineIntroModel(image: "HomePage3")
