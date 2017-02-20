//
//  TheCell.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/14/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class TheCell: UITableViewCell {
    
    var database: Database!
    var cache: Cache!
    var node: Node!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        database = appDelegate.database
        cache = appDelegate.cache
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(node: Node){
        // we could crash the whole program is we don't do that
        self.node = node
    }
    
    func save(node:Node){
        
    }
    
    func dismisskeyboard(){
    
    }
    
    func read()->String?{
        return nil
    }
}
