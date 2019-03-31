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
    //    var news: News?
    var title: String?
    var time: String?
    var news_content: String?
    //    var image: Image?
    var image: String?
}

//struct News: HandyJSON {
//}

//struct Image: HandyJSON {
//    var image_url: String?
//}

// Json 格式
//let testJSON = "{\"title\": \"Peer Support closed\", \"time\": \"February 12, 2019\", \"news_content\": \"Due to the weather our peer support services are closed today.\n Check out our Online Resources if you need support <3\", \"image\": \"https://www.youthline.ca/wp-content/uploads/2019/02/closed-weather-800x350.png\"}"
//
//let news1 = JSONDeserializer<NewsFeedModel>.deserializeFrom(json: testJSON)

func test() -> NewsFeedModel? {
    let testJSON = "{\"title\": \"Peer Support closed\", \"time\": \"February 12, 2019\", \"news_content\": \"Due to the weather our peer support services are closed today. Check out our Online Resources if you need support <3\", \"image\": \"https://www.youthline.ca/wp-content/uploads/2019/02/closed-weather-800x350.png\"}"
    if let news1 = JSONDeserializer<NewsFeedModel>.deserializeFrom(json: testJSON) {
        return news1
    } else {
        return nil
    }
}

func test1() -> NewsFeedModel? {
    let testJSON = "{\"title\": \"Two new programs at Youth Line!\", \"time\": \"January 29, 2019\", \"news_content\": \"YouthLine is thrilled to announce that we have two new programs starting in 2019! YouthOrganize & Provincial Youth Ambassador Project (PYAP) Read on for more details!Many 2SLGBTQ youth are doing important community building work in their communities, through groups, GSA’s, events, and collectives. Through the launch of our new program, YouthOrganize, we hope to connect with youth 29 and under who are creating community spaces where they live. Sometimes it can be hard to know where to start, or how to make your group or program the best it can be! We are launching a new online space to connect 2SLGBTQ youth leaders across Ontario with each other, and with experienced community builders who are excited to share their knowledge and experience with young people doing the work. Find more info at youthline.ca/youthorganize. If you are a 2SLGBTQ person (29 and under) doing work in your community, or know someone who is please fill out our survey and tell us what resources you need most in your communities! About the Provincial Youth Ambassador Project: The Provincial Youth Ambassador Project will foster leadership and engagement of 15 2SLGBTQ youth, across Ontario, to increase visibility and awareness of 2SLGBTQ needs and challenges, while creating resources for their local communities. Majority of the youth will be Indigenous, Black or youth of colour with priority given to trans youth. Read more about the project here. We’re hiring 2 new Coordinators for the PYAP: 1 position in Northern Ontario 1 position in GTHA (Greater Toronto and Hamilton Area), with preference given to candidates with lived experience in suburban/rural spaces Check out the full job postings and spread the word! Please send applications by Sunday, February 17th, 2018 at 11:59 pm to jobs@youthline.ca with subject line: Application for PYAP Coordinator.\"}"
    if let news1 = JSONDeserializer<NewsFeedModel>.deserializeFrom(json: testJSON) {
        return news1
    } else {
        return nil
    }
}
