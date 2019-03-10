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
    var news: News?
}

struct News: HandyJSON {
    var type: String? // type of news
    var news_content: NewsContent? // content of the news
}


struct NewsContent: HandyJSON {
    //    var video: Video?
    var title: Title?
    var image: Image?
    var content: Content?
}

struct Title: HandyJSON {
    var panel_text: String?
    //    var action: Action?
}

struct Content: HandyJSON {
    var panel_text: String?
}

struct Image: HandyJSON {
    var image_url: String?
}

// Fake Data
var image1 = Image(image_url: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/09/12/11/naturo-monkey-selfie.jpg?w968h681")
var title1 = Title(panel_text: "Test Data1 -- From FaceBook")
var content1 = Content(panel_text: "Raise $300.00 for Youthline at #ylcrafts to become a Master Crafter and have a chance to win a Rainbow Blanket Knitting Kit (yes, you read that right) from #woolandthegang at Crafthaton on March 16. It's not too late to join! bit.ly/craftathon19")
var news_content1 = NewsContent(title: title1, image: image1, content: content1)
var news1 = News(type: "FaceBook", news_content: news_content1)
var newsModel1 = NewsFeedModel(news: news1)

var image2 = Image(image_url: "https://iso.500px.com/wp-content/uploads/2016/02/stock-photo-114337435-1500x1000.jpg")
var title2 = Title(panel_text: "Test Data2 -- From FaceBook")
var content2 = Content(panel_text: "LALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALALA")
var news_content2 = NewsContent(title: title2, image: image2, content: content2)
var news2 = News(type: "Instagram", news_content: news_content2)
var newsModel2 = NewsFeedModel(news: news2)

