//
//  RequestManager.swift
//  
//
//  Created by Yolankyi SERHII on 8/26/19.
//

import UIKit
import Alamofire
import SwiftyJSON

class RequestManager {
    
    private let uid = "417f1112156476c839ce9c5300d15c4fca5fa5260b5a723390c61a981f51ed64"
    private let secred = "3f6d3b66ef3fb642c91d646b6fd13d8335b83b089b27bacfaada39e8b5493e18"
    private let site = "https://api.intra.42.fr/"
    private let redirectUrl = "swiftyCompanion%3A%2F%2FswiftyCompanion"
    
    func takeToken(completionHandler: @escaping(String?)->Void) {
        
        let reqUrl = site + "oauth/token?grant_type=client_credentials&client_id=\(uid)&client_secret=\(secred)"
        request(reqUrl, method: .post).authenticate(user: uid, password: secred).responseJSON { response in
            if response.data != nil {
                do {
                    let dict = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String: Any]
                    guard let token = dict["access_token"] as? String else {
                        completionHandler(nil)
                        return
                    }
                    completionHandler(token)
                } catch (let error) {
                    completionHandler(nil)
                    print(error.localizedDescription) }
            } else {
                completionHandler(nil)
            }
        }.resume()
    }
    
    
    func informationUser(userName: String, token: String, completionHandler: @escaping(JSON?)->Void) {
        
        let reqUrl = site + "v2/users/\(userName)/"
        let headers = ["Authorization": "Bearer " + token]
        request(reqUrl, method: .get, headers: headers).responseJSON { response in
            if response.result.isSuccess {
                completionHandler(JSON(response.value!))
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func infoAboutCoalition(userName: String, token: String, completionHandler: @escaping(JSON?)->Void) {
        
        let reqUrl = site + "v2/users/\(userName)/coalitions"
        let headers: HTTPHeaders = ["Authorization" : "Bearer " + token]
        request(reqUrl, method: .get, headers: headers).responseJSON { response in
            if response.result.isSuccess {
                completionHandler(JSON(response.value!))
            } else {
                completionHandler(nil)
            }
        }
    }
}
