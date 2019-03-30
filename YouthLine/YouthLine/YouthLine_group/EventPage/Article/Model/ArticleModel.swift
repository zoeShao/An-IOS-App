//
//  AnswerModel.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import Foundation
import HandyJSON

//Question
struct ZHQuestion: HandyJSON {
    var title: String?
    var answer_count: Int = 0
    var answerList: [Answer]?
    var id: String?
}

//Answer
struct Answer: HandyJSON {
    var id: String?
    var author: ZHAuthor?
    var excerpt: String?
    var voteup_count: Int = 0
    var thanks_count: Int = 0
    var comment_count: Int = 0
    var updated_time: Int = 0
    var thumbnail_info:ThumbnailInfo?
}

struct ThumbnailInfo: HandyJSON {
    var thumbnails: [ZHThumbnail]?
}

struct ZHThumbnail: HandyJSON {
    var url: String?
}

struct ZHFirstAnswer: HandyJSON {
    var excerpt: String?
    var voteup_count: Int = 0
    var pagination_info: AnswerIdList?
    var author: ZHAuthor?
}

struct AnswerIdList: HandyJSON {
    var next_answer_ids: [String]?
}

struct ZHAuthor: HandyJSON {
    var is_followed: Bool = false
    var gender: Int = 0
    var avatar_url: String?
    var headline: String?
    var id: String?
    var name: String?
    var is_privacy: Bool = false
}
