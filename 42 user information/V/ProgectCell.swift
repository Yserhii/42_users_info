//
//  ProgectCell.swift
//  42 user information
//
//  Created by Yolankyi SERHII on 7/28/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit

class ProgectCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet weak var projects: UILabel!
    @IBOutlet weak var projectMark: UILabel!
}
