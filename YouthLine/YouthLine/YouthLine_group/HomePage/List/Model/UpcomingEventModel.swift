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

struct EventAction: HandyJSON {
    var intent_url: String?
}

var eimage1 = EventImage(image_url: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/09/12/11/naturo-monkey-selfie.jpg?w968h681")
var etitle1 = EventTitle(panel_text: "Test Data -- Upcoming Event1")

var event1 = UpcomingEventModel(title: etitle1, image: eimage1)
