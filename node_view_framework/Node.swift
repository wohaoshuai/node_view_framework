//
//  Node.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/15/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import Foundation

class Node {
    
    var id: Int = -1
    var type: Int = -1
    
    var data: [String: String] = [:]
    var rules: [String:Any] = ["Touch": ["1", "Expand"] , "Expand":["0"], "back_expand":["0"], "display":["0"], "action_list": ["0"]]
    
    init(){
        
    }
    
    init(id:Int) {
        self.id = id
    }
    
    init(id: Int, type: Int, data: [String:String]){
        self.id = id
        self.type = type
        self.data = data
    }
    
    
}
