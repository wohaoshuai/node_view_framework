//
//  NVView.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/24/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class NVView: UIView {
    var node:Node?
    var flipped: Bool = false
    var start: CGPoint?
    var buffer: CGSize?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tap_enable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func tap_enable(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tap)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        self.addGestureRecognizer(pan)
    }
    
    func handleTap(sender: UITapGestureRecognizer){
        
        if sender.state == .ended{
            flip_select()
        }
    }
    
    func handlePan(sender: UIPanGestureRecognizer){
        if sender.state == .ended || sender.state == .cancelled{
            UIView.animate(withDuration: 0.4, animations: {self.frame.origin = self.start!})
            print("End")
        } else if sender.state == .began{
            print(sender.translation(in: self))
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            UIView.animate(withDuration: 1.3, delay: 0, usingSpringWithDamping: CGFloat(0.2), initialSpringVelocity: CGFloat(6.0), options: UIViewAnimationOptions.allowUserInteraction, animations: {self.transform = CGAffineTransform.identity}, completion: nil)
            
            start = self.frame.origin
        } else if sender.state == .changed{
            print(sender.translation(in: self))
            
            let t = sender.translation(in: self)
            let c = sender.view!.center
            sender.view?.center = CGPoint(x: c.x + t.x , y: c.y + t.y)
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self)
        }
    }
    
    func flip_select(){
        if flipped == true {
            backnormal()
        } else {
            highlight()
        }
        flipped = !flipped
    }
    
    func highlight(){
        let block = self
        let red = CGFloat(74 / 255.0)
        let green = CGFloat(193.0 / 255.0)
        let blue = CGFloat(236.0 / 255.0)
        let alpha = CGFloat(65.0 / 255.0)
        block.layer.shadowColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
        block.layer.shadowOpacity = 1
        block.layer.shadowRadius = 5
        block.layer.shadowOffset = CGSize(width: 0, height: 0)
//        block.layer.shouldRasterize = true
//        block.layer.rasterizationScale = 2.0
    }
    
    func backnormal(){
        let block = self
        
        let red = CGFloat(167 / 255.0)
        let green = CGFloat(180.0 / 255.0)
        let blue = CGFloat(195.0 / 255.0)
        let alpha = CGFloat(1.0)
        
        block.layer.shadowColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
        block.layer.shadowOpacity = 0.9
        block.layer.shadowRadius = 3
        block.layer.shadowOffset = CGSize(width: 2, height: 1)
    }

    
    
}
