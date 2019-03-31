//
//  Model.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import Foundation
import HandyJSON

struct EventModel: HandyJSON {
    var rid: String?
    var address: String?
    var event_date: String?
    var map: String?
    var image_url: String?
    var release_data: String?
    var main_content: String?
    var event_time: String?
    var source: String?
    var title: String?
    var event_website: String?
    var b_content: String?
}
