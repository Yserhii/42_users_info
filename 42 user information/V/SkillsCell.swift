//
//  skillsCell.swift
//  42 user information
//
//  Created by Yolankyi SERHII on 7/28/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit

class SkillsCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        progressViewSkills.layer.cornerRadius = 2
        progressViewSkills.clipsToBounds = true
    }
    
    @IBOutlet weak var skills: UILabel!
    @IBOutlet weak var progressViewSkills: UIProgressView!

    
}
