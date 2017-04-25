//
//  MyClass.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/27/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import Foundation

class MyClass: NSObject {
    required public override init() { print("Hi!") }
    
    public func test(){
        print("testing")
    }
    
    public class func static_test(i: Int){
        print("testing")
    }
    
    
}
