//
//  Cell5.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/15/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class Cell5: TheCell {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func update(node: Node) {
//        print("updating cell 5...")
        
        label1.text = node.data["text"]
        
        if let imgName = node.data["img"]{
            img1.image = UIImage(named: imgName)
        }
//        print("cell 5 updated")
    }
}
