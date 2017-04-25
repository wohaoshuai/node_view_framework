//
//  layoutStack.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/26/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class LayoutStack{
    var stack = [UIView]()

    var origin: CGPoint = CGPoint(x: 0, y: 20)
    var gap: CGFloat = 10
    var maxX: CGFloat?
    var maxY: CGFloat?
    var minX: CGFloat?
    var minY: CGFloat?
    
    var guideX = [CGFloat]()
    var guideYBottom: CGFloat?
    var guideYTop: CGFloat?
    
    func frames()->[CGRect]{
        let n = stack.count
        if n == 0 {
            return []
        }
        

        var res = [CGRect]()
        var px = origin.x
        var py = origin.y
        
        for i in 0...(n - 1){
            let w = stack[i].frame.size.width
            let h = stack[i].frame.size.height
            let rect = CGRect(x: px, y: py, width: w, height: h)
            px += w + gap
            res.append(rect)
        }
        print("==res==")
        print(res)
        return res
    }
    
}
