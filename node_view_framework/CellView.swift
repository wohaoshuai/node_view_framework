//
//  CellView.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/22/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

// NibLoadingView.swift
import UIKit

// Usage: Subclass your UIView from NibLoadView to automatically load a xib with the same name as your class

class CellView: UIView {
    
    @IBOutlet weak var label: UILabel!
    class func instanceFromNib() -> CellView {
        return UINib(nibName: "CellView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CellView
    }
    
}
