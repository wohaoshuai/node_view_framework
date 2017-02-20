//
//  Cell1.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/14/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class Cell1: TheCell {
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // mapping
    // field1 - a text in the view - need a String to specify what to be displayed
    override func update(node: Node) {
        name.text = node.data["text"]
    }
    
}
