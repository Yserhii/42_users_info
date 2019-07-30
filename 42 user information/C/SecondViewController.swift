//
//  SecondViewController.swift
//  42 user information
//
//  Created by Yolankyi SERHII on 7/27/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var imageViewCoalition: UIImageView!
    @IBOutlet weak var backGraund: UIImageView!

    @IBOutlet weak var coalition: UILabel!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var emalLable: UILabel!
    
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var numPoints: UILabel!
    @IBOutlet weak var walet: UILabel!
    @IBOutlet weak var numWalet: UILabel!
    @IBOutlet weak var etec: UILabel!
    @IBOutlet weak var numEtec: UILabel!

    @IBOutlet weak var lvlProgress: UILabel!
    @IBOutlet weak var progressViewLvl: UIProgressView!

    @IBOutlet weak var tableViewSkill: UITableView!
    @IBOutlet weak var tableViewProjects: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var num: Int
        
        if tableView == tableViewSkill {
            num = allUserSkils.count
        } else {
            num = allUserrProgects.count
        }
        return num
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewSkill {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skills") as? SkillsCell
            cell?.skills.text = "\(allUserSkils[indexPath.row].name ?? "No skill")"
            cell?.progressViewSkills.progress = (allUserSkils[indexPath.row].level ?? 0.0) / 21
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "projects") as? ProgectCell
            cell?.projects.text = allUserrProgects[indexPath.row].name
            cell?.projectMark.text = String(describing: allUserrProgects[indexPath.row].mark!)
            if allUserrProgects[indexPath.row].isValidate! {
                cell?.projectMark?.textColor = .green
            } else {
                cell?.projectMark?.textColor = .red
            }
            return cell!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressViewLvl.layer.cornerRadius = 4
        progressViewLvl.clipsToBounds = true
        userInfor()
        userSkills()
        userProjects()
    }
    
    func userInfor() {
        if let imageUrl = URL(string: allInfoUser!["image_url"].string ?? "") {
            if let photoData = try? Data(contentsOf: imageUrl) {
                imageViewPhoto.image = UIImage(data:photoData)?.circularImage(size: nil)
            }
        }
        coalition.text = allInfoCoalition![0]["name"].string ?? ""
        switch coalition.text {
            case "The Alliance":
                imageViewCoalition.image = UIImage(imageLiteralResourceName: "The_Alliance")
                backGraund.image = UIImage(imageLiteralResourceName: "Alliance_Background")
            case "The Empire":
                imageViewCoalition.image = UIImage(imageLiteralResourceName: "The_Empire")
                backGraund.image = UIImage(imageLiteralResourceName: "Empire_Background")
            case "The Hive":
                imageViewCoalition.image = UIImage(imageLiteralResourceName: "The_Hive")
                backGraund.image = UIImage(imageLiteralResourceName: "Hive_Background")
            case "The Union":
                imageViewCoalition.image = UIImage(imageLiteralResourceName: "The_Union")
                backGraund.image = UIImage(imageLiteralResourceName: "Union_Background")
            default :
                if let imageUrlCoalitionsBackground = URL(string: allInfoCoalition![0]["cover_url"].string ?? "") {
                    if let coalitionsData = try? Data(contentsOf: imageUrlCoalitionsBackground) {
                        backGraund.image = UIImage(data: coalitionsData)!
                    }
                }
        }
        self.imageViewCoalition.changePngColorTo(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        name.text = allInfoUser!["displayname"].string ?? ""
        login.text = allInfoUser!["login"].string ?? ""
        let phoneNum = allInfoUser!["phone"].string ?? ""
            phone.text = phoneNum
        let pointNum = allInfoUser!["correction_point"].int ?? 0
            numPoints.text = "\(pointNum)"
        let walletNum = allInfoUser!["wallet"].int ?? 0
            numWalet.text = "\(walletNum)"
        let year = allInfoUser!["pool_year"].string ?? ""
            numEtec.text = "\(year)"
        let email = allInfoUser!["email"].string ?? ""
            emalLable.text = "\(email)"
        if let level = allInfoUser!["cursus_users"][0]["level"].float {
            lvlProgress.text = "Level progress: \(level)%"
            progressViewLvl.progress = level / 21
        }
    }
    
    func userSkills() {
        let skills = allInfoUser!["cursus_users"][0]["skills"]
        for skill in skills {
            var sk = Skill.init()
            sk.name = skill.1["name"].string ?? ""
            sk.level = skill.1["level"].float ?? 0.0
            allUserSkils.append(sk)
        }
    }
    
    func userProjects() {
        let projects = allInfoUser!["projects_users"]
        for project in projects {
            if project.1["status"].string == "finished" {
                var pr = Project.init()
                pr.name = project.1["project"]["name"].string ?? ""
                pr.mark = project.1["final_mark"].int ?? 0
                pr.isValidate = project.1["validated?"].bool ?? false
                allUserrProgects.append(pr)
            }
        }
    }
}
