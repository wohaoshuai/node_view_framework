//
//  UIIView.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/25/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

enum LayoutPolicy{
    case free
    case stack(LayoutStack)
    case map
    case priority([LayoutPolicy])
}

enum NVFunction{
    case atomic([String])
    case sequential([NVFunction])
}

enum NVData{
    case rawData(String)
    case nameData(String)
}

enum NVCustom{
    case depend(String, String, NVFunction)  // child , parent, dependency_function
}

enum NVCustomForm{
    case update(String, Any) // name + updating data
}

class UIIView: UIScrollView {

    var state: Int = 0
    var enabletouch: Bool = false
    var layoutPolicy = LayoutPolicy.free
    var transition = NVTransition.popWindow("?")
    var customList: [NVCustom] = []
        // [NVCustom.depend("contentSize", "frame", NVFunction.atomic(["equal"]))]
        
    // LayoutPolicy.stack(LayoutStack())
    
    func layoutSubviews2(){
        switch layoutPolicy {
        case .stack(var s):
            s.stack = subviews
            let frames = s.frames()
            var i = 0
            print("==stack==")
            for view in s.stack{
                // DEBUG
                
                print(view.frame)
                print(i, frames[i])
                view.frame = frames[i]
                i += 1
            }
        default:
            print("Not Yet... >_<")
        }
    }
    
    // a = b , no deep copy , just standard swift
    // NOT USED
//    func equal(a: Any?, b: Any?)->Bool{
//        if let a_exsist = a{
//            a = b
//            return true
//        } else {
//            return false
//        }
//    }
    
    // the whole custom system - should be able to caputure as data
    func updateThroughCustom(form: NVCustomForm)->Bool{
        var status = true
        for custom in customList{
            switch custom {
            case let .depend(child, parent, function):
                
                switch form {
                case let .update(dataID, data):
                    if (parent == dataID){ // this is a specific relation - funciton is preferred
                        updater(id: parent, data: data)
                        updater(id: child, data: (data as! CGRect).size)
                        print("Form Succeed. Data Mactched!")
                        return true
                    }
                    if (child == dataID){
                        print("Custom Rule Violated - No Update for Child")
                        return false
                    }
                default:
                    print("Form is non-relavent to this custom rule: NVCustom.depend")
                    print("Pass on \(custom)")
                }
                
            default:
                print("HI! Welcome to UIIView National Custom...balabalah >_<")
                print("Pass on \(custom)")
            }
        }
        print("Your From Does Not Violate Any Rule, but it's rather useless = =+")
        return false
    }
    
    func updater(id: String, data: Any){
        switch id {
        case "contentSize":
            print("try update contentSize")
            self.contentSize.width = (data as! CGSize).width
            print(contentSize)
        case "frame":
            print("try update frame")
            self.frame = data as! CGRect
        default:
            print("no update")
        }
    }
}
