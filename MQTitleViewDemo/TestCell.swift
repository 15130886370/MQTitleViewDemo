//
//  TestCell.swift
//  MQTitleViewDemo
//
//  Created by ittmomWang on 16/8/26.
//  Copyright © 2016年 ittmomWang. All rights reserved.
//

import UIKit

class TestCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
