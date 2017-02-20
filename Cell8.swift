//
//  Cell8.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/18/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class Cell8: TheCell {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var lebel1: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchButton1(_ sender: UIButton) {
      //  sender.isSelected = !sender.isSelected
        
        NotificationCenter.default.post(name: Notification.Name("button_touch"), object: self.node)
    }
    
    override func update(node: Node) {
        super.update(node: node)
        print("Yes==================")
        let str = node.data["switch"]
        
        
        if let button_title = node.data["button_title"] {
            button1.setTitle(button_title, for: UIControlState.normal)
        }
        
        if let button_background = node.data["button_background"] {
            button1.setBackgroundImage(UIImage(named: button_background), for: UIControlState.normal)
            
        }
        
        if let button_title1 = node.data["button_title1"] {
            button1.setTitle(button_title1, for: UIControlState.selected)
        }
        
        if let button_background1 = node.data["button_background1"] {
            button1.setBackgroundImage(UIImage(named: button_background1), for: UIControlState.selected)
        }
        
        if let text_color = node.data["textcolor"]{
           button1.setTitleColor(UIColor.green, for: UIControlState.normal)
        }
        
        if str == "true"{
            self.button1.isSelected = true
        }
        
        if str == "false"{
            self.button1.isSelected = false
        }
        
        if str == "flip"{
            let new_value = !self.button1.isSelected
            self.button1.isSelected = new_value
            if new_value == true {
                node.data["switch"] = "true"
            } else {
                node.data["switch"] = "false"
            }
        }
        
        if str == "blink"{
            let new_value = !self.button1.isSelected
            self.button1.isSelected = new_value
        }
        
        lebel1.text = node.data["text"]
    }
}
