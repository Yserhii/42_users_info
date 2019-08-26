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
    
    private var bearerToken: String = ""
    private let requestManager = RequestManager()
    @IBOutlet weak var userName: UITextField!
    @IBAction func searchClick(_ sender: UIButton) {
        search()
    }
    
    func search() {
        if userName.text != "" && userName.text != nil && bearerToken != "" {
            print(userName.text!)
            userName.text = userName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            infoAboutCoalition()
            informationUser()
        } else if userName.text == "" || userName.text == nil {
            self.alertError(title: "Error", message: "Field login")
        } else if bearerToken == ""{
            self.alertError(title: "Error", message: "Invalid login or bad connection. Try again.")
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
}

extension ViewController {
    
    func alertError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension ViewController {
    
    func takeToken() {
        
        requestManager.takeToken(completionHandler: {(response) in
            if let respons = response {
                self.bearerToken = respons
                print(respons)
            } else {
                self.alertError(title: "Error", message: "Error in response, can't get token")
            }
        })
    }
    
    func informationUser() {
        
        requestManager.informationUser(userName: userName.text!, token: bearerToken, completionHandler: {(response) in
            if response != nil {
                allInfoUser = response
                if response!["error"] == "Not authorized" {
                    self.alertError(title: "Error", message: "Bad server connection")
                    return
                }
                if response!.isEmpty {
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
        })
    }
    
    func infoAboutCoalition() {
        requestManager.infoAboutCoalition(userName: userName.text!, token: bearerToken, completionHandler: {(response) in
            if response != nil {
                allInfoCoalition = response
                if allInfoCoalition!["error"] == "Not authorized" || allInfoCoalition!.isEmpty {
                    return
                }
                print(allInfoCoalition![0]["name"])
            } else {
                return
            }
        })
    }
}
