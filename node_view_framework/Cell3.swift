//
//  Cell3.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/14/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class Cell3: TheCell {
    @IBOutlet weak var switchIt: UISwitch!
    @IBOutlet weak var label: UILabel!
    
//        {
//        didSet{
//            if label.text == "On" {
//                switchIt.setOn(true, animated: false)
//            }else {
//                switchIt.setOn(false, animated: false)
//            }
//            
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func changed(_ sender: UISwitch) {
        if sender.isOn {
            label.text = "On"
        } else {
            label.text = "Off"
        }
    }
    
    override func update(node: Node) {
        
    }
    
}
