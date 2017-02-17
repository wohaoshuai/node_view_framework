//
//  Cell7.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/16/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class Cell7: TheCell {
    
    @IBOutlet weak var button1: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func button_touched(_ sender: UIButton) {
        print("to read!!!")
        NotificationCenter.default.post(name: Notification.Name("aixuexi"), object: nil)
    }
    
    
}
