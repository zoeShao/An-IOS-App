//
//  UpcomingEventModel.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import Foundation
import HandyJSON

struct UpcomingEventModel: HandyJSON {
    var title: EventTitle?
    var image: EventImage?
}

struct EventTitle: HandyJSON {
    var panel_text: String?
    //    var action: EventAction?
}

struct EventImage: HandyJSON {
    var image_url: String?
}

//struct EventAction: HandyJSON {
//    var intent_url: String?
//}

// Fake Data
var eimage1 = EventImage(image_url: "https://www.youthline.ca/wp-content/uploads/2019/02/25thAnn_FacebookPageCover.jpg")
var etitle1 = EventTitle(panel_text: "25th Anniversary & Youth Awards Gala")
var event1 = UpcomingEventModel(title: etitle1, image: eimage1)

var eimage2 = EventImage(image_url: "https://www.youthline.ca/wp-content/uploads/2018/11/2B.png")
var etitle2 = EventTitle(panel_text: "Craftathon 19")
var event2 = UpcomingEventModel(title: etitle2, image: eimage2)
