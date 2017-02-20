//
//  Cell2.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/14/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class Cell2: TheCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func update(node: Node) {
        label.text = node.data["text"]
        
        if let imgName = node.data["img"]{
            imgView.image = UIImage(named: imgName)
        }
    }
}
