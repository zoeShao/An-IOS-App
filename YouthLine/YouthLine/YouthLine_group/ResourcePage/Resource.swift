//
//  Resource.swift
//  YouthLine
//
//  Created by Yuting Shao on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import Foundation
import UIKit

class Resource {
    
    //    var image: UIImage
    var image: String
    var title: String
    var url: URL
    
    //    init(image: UIImage, title: String, url: URL) {
    init(image: String, title: String, url: URL) {
        self.image = image
        self.title = title
        self.url = url
    }
}
