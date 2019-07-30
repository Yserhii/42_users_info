//
//  ViewController.swift
//  42 user information
//
//  Created by Yolankyi SERHII on 7/26/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
    
    var bearerToken: String = ""
    var informationAboutUser: String = ""
    @IBOutlet weak var userName: UITextField!
    @IBAction func searchClick(_ sender: UIButton) {
        search()
    }
    
    func search() {
        if userName.text == "" || userName.text == nil {
            alertError(title: "Error", message: "Field login")
        } else {
            print(userName.text!)
            userName.text = userName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            infoAboutCoalition()
            informationUser()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        userName.delegate = self
        takeToken()
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        search()
        return true
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func alertError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func takeToken () {
        
        let data = myData.init()
        let reqUrl = data.site + "oauth/token?grant_type=client_credentials&client_id=\(data.uid)&client_secret=\(data.secred)"
        
        request(reqUrl, method: .post).authenticate(user: data.uid, password: data.secred)
        .responseJSON { response in
            if response.data != nil {
                do {
                    let dict = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String: Any]
                    guard let token = dict["access_token"] as? String else { return }
                    self.bearerToken = token
                    print(self.bearerToken)
                } catch (let error) { print(error.localizedDescription) }
            } else {
                print("Error in response")
            }
        }
    }
    
    func informationUser() {
        
        let data = myData.init()
        let reqUrl = data.site + "v2/users/\(userName.text!)/"
        let headers = ["Authorization": "Bearer " + bearerToken]
        
        request(reqUrl, method: .get, headers: headers).responseJSON { response in
            if response.result.isSuccess {
                allInfoUser = JSON(response.value!)
                if allInfoUser!["error"] == "Not authorized" {
                    self.alertError(title: "Error", message: "Тo server connection")
                    return
                }
                if allInfoUser!.isEmpty {
                    self.alertError(title: "Error", message: "Invalid login. Try again.")
                    return
                }
                print(allInfoUser!["displayname"])
                self.userName.text! = ""
                self.view.endEditing(true)
                self.performSegue(withIdentifier: "userInfo", sender: nil)
            } else {
                self.alertError(title: "Error", message: "Invalid login. Try again.")
            }
        }
    }
    
    func infoAboutCoalition() {
        
        let data = myData.init()
        let reqUrl = data.site + "v2/users/\(userName.text!)/coalitions"
        let headers: HTTPHeaders = ["Authorization" : "Bearer " + bearerToken]
        
        request(reqUrl, method: .get, headers: headers).responseJSON { response in
            if response.result.isSuccess {
                allInfoCoalition = JSON(response.value!)
                if allInfoCoalition!["error"] == "Not authorized" {
                    return
                }
                if allInfoCoalition!.isEmpty {
                    return
                }
                print(allInfoCoalition![0]["name"])
            } else {
                return
            }
        }
    }
}
