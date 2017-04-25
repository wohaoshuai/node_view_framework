//
//  NVLeadingGradientLayer.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/24/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class NVLeadingGradientLayer: CAGradientLayer {
    init(view: UIView) {
        super.init()
        colors        = [UIColor(white: 0.1, alpha: 0.6).cgColor, UIColor(white: 0.1, alpha: 0.4).cgColor, UIColor.clear.cgColor]
        locations     = [0.0, 0.2, 1.0 ]
        
        startPoint    = CGPoint(x: 0, y: 0.5)
        endPoint      = CGPoint(x: 1, y: 0.5)
        frame         = CGRect(x: 0, y: 0, width: 5, height: view.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
