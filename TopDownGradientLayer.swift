//
//  TopDownGradientLayer.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/25/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class TopDownGradientLayer: CAGradientLayer {
    init(view: UIView, s: String, e:String) {
        super.init()
        
        print(s, e)
        let sc = s.hexColor.cgColor
        let ec = e.hexColor.cgColor
        
        //view.clipsToBounds = true
        colors        = [sc, ec]
        locations     = [0.0, 1.0 ]
        
        startPoint    = CGPoint(x: 0.5, y: 0)
        endPoint      = CGPoint(x: 0.5, y: 1)
        frame         = view.bounds
        
        print(sc)
        print(ec)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
