//
//  AnswerAPI.swift
//  YouthLine
//
//  Created by Yecheng Song on 2019-03-09.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//
import Foundation
import HandyJSON
import Moya

let AnswerProvider = MoyaProvider<AnswerAPI>()

enum AnswerAPI {
    case list(String, Int)
    case detail(String)
    case question(String)
    case commentList(String, Int)
}

extension AnswerAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.zhihu.com")!
    }
    

    public var path: String {
        switch self {
        case let .list(questionId, _):
            return "/v4/questions/" + questionId + "/answers"
        case let .detail(answerId):
            return "/v4/answers/" + answerId
        case let .question(answerId):
            return "/v4/answers/" + answerId + "/question"
        case let .commentList(answerId, _):
            return "/answers/" + answerId + "/root_comments"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    

    public var task: Task {
        var parmeters: [String: Any] = [:]
        switch self {
        case let .list(_, offset):
            parmeters = ["limit": 10,
                         "offset": offset,
                         "reverse_order": 0,
                         "show_detail": 1]
        case .detail:
            parmeters = ["with_pagination": 1]
        case let .commentList(_,offset):
            parmeters = ["limit": 10,
                         "offset": offset]
        default:
            return .requestPlain
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    

    public var validate: Bool {
        return false
    }
    

    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String: String]? {
        return Headers
    }
}
