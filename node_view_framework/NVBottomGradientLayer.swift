//
//  NVBottomGradientLayer.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/24/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class NVBottomGradientLayer: CAGradientLayer {
    init(view: UIView) {
        super.init()
        colors        = [UIColor(white: 0.1, alpha: 0.6).cgColor, UIColor(white: 0.1, alpha: 0.5).cgColor, UIColor.clear.cgColor]
        locations     = [0.0, 0.1, 1.0 ]
        
        startPoint    = CGPoint(x: 0.5, y: 1.0)
        endPoint      = CGPoint(x: 0.5, y: 0.0)
        frame         = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: -3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
