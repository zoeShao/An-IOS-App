//
//  ResourceModel.swift
//  YouthLine
//
//  Created by Yuting Shao on 2019-03-30.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import Foundation
import HandyJSON
import Alamofire
import SwiftyJSON

struct ResourceCollectionModel: HandyJSON {
    var Resources: [CategoryModel]?
}

struct CategoryModel: HandyJSON {
    var category: String?
    var contents: [ResourceModel]?
}

struct ResourceModel: HandyJSON {
    var image: String?
    var resource_url: String?
    var title: String?
}

// With Alamofire
var resourcesCollection:[String: [Resource]] = ["all":[], "favourite": [], "settlement":[], "faith":[], "sex": [], "forms": [], "service":[], "education":[], "type":[], "health":[], "parents": [], "gender": [], "selfcare": [], "homelessness": [], "trans": [], "school": [], "comingout": [], "emergency": [], "community": [], "selfharm": [], "bullying": []]

//func fetchData() {
//    let url = "http://youthline-test-server.herokuapp.com/resources"
//    Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
//        .responseJSON { response in
////            print(response)
//            //to get status code
//            if let status = response.response?.statusCode {
//                switch(status){
//                case 200:
//                    print("example success")
//                    //to get JSON return value
//                    if let result = response.result.value {
////                        let JSON = result as! NSDictionary
//                        let json = JSON(result)
//                        for i in 0..<json["Resources"].count {
//                            if let categoryName = json["Resources"][i]["category"].string {
//                                print(categoryName)
//                                for j in 0..<json["Resources"][i]["contents"].count {
//
//                                    let resourceTitle = json["Resources"][i]["contents"][j]["title"].string!
//                                    let resourceURL = json["Resources"][i]["contents"][j]["resource_url"].string!
//                                    let imageURL = json["Resources"][i]["contents"][j]["img"].string!
//                                    print(resourceTitle)
//                                    print(resourceURL)
//                                    print(imageURL)
//                                    let resource = Resource(image: imageURL, title: resourceTitle, url: URL(string: resourceURL)!)
//                                    resourcesCollection["all"]!.append(resource)
//                                    resourcesCollection[categoryName]!.append(resource)
//                                }
//
//                            } else {
//                                //Print the error
//                                print("error, wrong key")
//                            }
//                        }
//                        ResourceBaseVC.tableView.reloadData()
////                        print(json)
//                    }
//                default:
//                    print("error with response status: \(status)")
//                }
//            }
////            //to get JSON return value
////            if let result = response.result.value {
////                let JSON = result as! NSDictionary
////                print(JSON)
////            }
//        }
//}


//func hello(){
//    let url = URL(string: "http://youthline-test-server.herokuapp.com/event")
//    Alamofire.request(url ?? "").responseJSON { (responseObject) -> Void in
//
//        print("hellohello", responseObject, "hellohello")
//
//
//    }
//}
