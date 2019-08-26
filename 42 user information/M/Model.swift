//
//  Mode.swift
//  42 user information
//
//  Created by Yolankyi SERHII on 7/27/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Skill {
    var name: String?
    var level: Float?
}

struct Project {
    var name: String?
    var mark: Int?
    var isValidate: Bool?
}

var allInfoUser: JSON?
var allInfoCoalition: JSON?
var allUserSkils: [Skill] = []
var allUserrProgects: [Project] = []
