//
//  Cell6.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/16/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class Cell6: TheCell {
    
    @IBOutlet weak var textField1: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func update(node: Node){
        textField1.text = node.data["textinput"]
        textField1.placeholder = node.data["placeholder"]
    }
    
    override func save(node: Node) {
        if let text = textField1.text{
            node.data["textinput"] = text
        }
    }
    
    override func read() -> String? {
        if let text = textField1.text{
            return text
        } else {
            return nil
        }
    }
    
}
