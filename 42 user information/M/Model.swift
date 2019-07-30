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

struct myData {
    let uid = "417f1112156476c839ce9c5300d15c4fca5fa5260b5a723390c61a981f51ed64"
    let secred = "3f6d3b66ef3fb642c91d646b6fd13d8335b83b089b27bacfaada39e8b5493e18"
    let site = "https://api.intra.42.fr/"
    let redirectUrl = "swiftyCompanion%3A%2F%2FswiftyCompanion"
}

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
