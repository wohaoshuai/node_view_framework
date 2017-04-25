//
//  NVInnerShadowLayer.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/24/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class NVTopGradientLayer: CAGradientLayer {
    
    init(view: UIView) {
        super.init()
        
//        self.colors = [UIColor.black, UIColor.white]
//        self.shadowRadius = 10
//        
//        let f = view.frame
//        self.startPoint = CGPoint(x: 0.5, y: 0.0)
//        self.endPoint = CGPoint(x: 0.5, y: 1.0)
//        self.frame = CGRect(x: 0.0, y: 0.0, width: f.width, height: shadowRadius)
//        print(f.width)
        
        //let size = view.frame.size
        
//        let layer: CALayer = CALayer()
//        bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        backgroundColor = UIColor.lightGray.cgColor
//        position = CGPoint(x: size.width / 2, y: -size.height / 2 + 0.5)
//        
//        shadowColor = UIColor.darkGray.cgColor
//        shadowOffset = CGSize(width: 0.5, height: 0.5)
//        shadowOpacity = 1.0
//        shadowRadius = 5.0
//        
        
        startPoint    = CGPoint(x: 0.5, y: 0.0)
        endPoint      = CGPoint(x: 0.5, y: 1)
//        colors        = [UIColor(white: 0.1, alpha: 1.0).cgColor, UIColor(white: 0.1, alpha: 0.5).cgColor, UIColor.clear.cgColor]
//        locations     = [0.05, 0.2, 1.0 ]
        frame         = CGRect(x: 0, y: 0, width: view.frame.width, height: 5)
        colors        = [UIColor(white: 0.2, alpha: 0.8).cgColor, UIColor.clear.cgColor]
        locations     = [0.0, 1]
        //view.addSublayer(layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Create a shadow layer for a specified edge on a specified view.
    ///
    ///  - parameter forView: The `UIView`. The view's frame is used to set up
    ///    the layer's frame, but the layer itself is **not** attached to the
    ///    view in this initializer.
    ///  - parameter edge: The edge of the view that will get the shadow. The
    ///    default is Edge.Top.
    ///  - parameter shadowRadius: The width or depth of the shadow. The default
    ///    is 20.
    ///  - parameter toColor: The color to fade to (i.e. furthest from the
    ///    view's edge). The default is UIColor.whiteColor().
    ///  - parameter fromColor: The color to fade from (i.e. closest to the
    ///    view's edge). The default is UIColor.blackColor().
//    public init(forView view: UIView,
//                edge: Edge = Edge.Top,
//                shadowRadius radius: CGFloat = 20.0,
//                toColor: UIColor = UIColor.whiteColor(),
//                fromColor: UIColor = UIColor.blackColor()) {
//        super.init()
//        self.colors = [fromColor.CGColor, toColor.CGColor]
//        self.shadowRadius = radius
//        
//        // Set up its frame.
//        let viewFrame = view.frame
//        
//        switch edge {
//        case .Top:
//            startPoint = CGPoint(x: 0.5, y: 0.0)
//            endPoint = CGPoint(x: 0.5, y: 1.0)
//            self.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: shadowRadius)
//        case .Bottom:
//            startPoint = CGPoint(x: 0.5, y: 1.0)
//            endPoint = CGPoint(x: 0.5, y: 0.0)
//            self.frame = CGRect(x: 0.0, y: viewFrame.height - shadowRadius, width: viewFrame.width, height: shadowRadius)
//        case .Left:
//            startPoint = CGPoint(x: 0.0, y: 0.5)
//            endPoint = CGPoint(x: 1.0, y: 0.5)
//            self.frame = CGRect(x: 0.0, y: 0.0, width: shadowRadius, height: viewFrame.height)
//        case .Right:
//            startPoint = CGPoint(x: 1.0, y: 0.5)
//            endPoint = CGPoint(x: 0.0, y: 0.5)
//            self.frame = CGRect(x: viewFrame.width - shadowRadius, y: 0.0, width: shadowRadius, height: viewFrame.height)
//        }
}
