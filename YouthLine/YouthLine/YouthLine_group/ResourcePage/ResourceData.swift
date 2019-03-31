//
//  ResourceData.swift
//  YouthLine
//
//  Created by Yuting Shao on 2019-03-30.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import Foundation


var resourcesCollection = [String: [Resource]]()

//var resources: [Resource] = []


func createDic() -> [String: [Resource]] {
    var tempResources:[String: [Resource]] = ["all":[], "favourite": [], "settlement":[], "faith":[], "sex": [], "forms": [], "service":[], "education":[], "type":[], "health":[], "parents": [], "gender": [], "selfcare": [], "homelessness": [], "trans": [], "school": [], "comingout": [], "emergency": [], "community": [], "selfharm": [], "bullying": []]

    let resource1 = Resource(image: "https://anytimeesl.ca/wp-content/uploads/2017/07/settlement.jpg", title: "Settlement.Org: Sexual Orientation and Gender Identity", url: URL(string: "https://settlement.org/ontario/health/sexual-and-reproductive-health/sexual-orientation-and-gender-identity/")!)


//    let resource1 = Resource(image: #imageLiteral(resourceName: "settlement"), title: "Settlement.Org: Sexual Orientation and Gender Identity", url: URL(string: "https://settlement.org/ontario/health/sexual-and-reproductive-health/sexual-orientation-and-gender-identity/")!)
//    let resource2 = Resource(image: #imageLiteral(resourceName: "forward_partners"), title: "transACTION: A Transgender Curriculum and Learner's Guide For Churches and Religious Institutions", url: URL(string: "https://www.youthline.ca/get-support/links-resources/")!)
//    let resource3 = Resource(image: #imageLiteral(resourceName: "BexTalksSex"), title: "Yes No Maybe: sex, kink, and language spreadsheets", url: URL(string: "https://www.bextalkssex.com/yes-no-maybe/")!)
//    let resource4 = Resource(image: #imageLiteral(resourceName: "form"), title: "How Do I Change the Sex Designation on my Identity Documents?", url: URL(string: "https://jfcy.org/en/rights/government-issued-identification/")!)
//    let resource5 = Resource(image: #imageLiteral(resourceName: "TransCareGuide"), title: "Trans Primary Care: My Guide to Caring for Trans and Gender-Diverse Clients", url: URL(string: "https://www.rainbowhealthontario.ca/TransHealthGuide/")!)
//    let resource6 = Resource(image: #imageLiteral(resourceName: "thebodyisnotanapology"), title: "The Body is Not An Apology", url: URL(string: "https://thebodyisnotanapology.com/")!)
//    let resource7 = Resource(image: #imageLiteral(resourceName: "2spirit"), title: "Briarpatch Magazine: Hearing Two Spirits", url: URL(string: "https://briarpatchmagazine.com/articles/view/hearing-two-spirits")!)
    tempResources["all"]!.append(resource1)

//    tempResources["all"]!.append(resource2)
//    tempResources["all"]!.append(resource3)
//    tempResources["all"]!.append(resource4)
//    tempResources["all"]!.append(resource5)
//    tempResources["all"]!.append(resource6)
//    tempResources["all"]!.append(resource7)
//    tempResources["settlement"]!.append(resource1)
//    tempResources["faith"]!.append(resource2)
//    tempResources["sex"]!.append(resource3)
//    tempResources["forms"]!.append(resource4)
//    tempResources["service"]!.append(resource5)
//    tempResources["education"]!.append(resource6)
//    tempResources["type"]!.append(resource7)
    
    return tempResources
}


