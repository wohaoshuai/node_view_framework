//
//  ViewerController.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/22/17.
//  Copyright © 17 alien_robot_cat. All rights reserved.
//

import UIKit

let SIZE = 25;

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

class ViewerController: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var contentview: UIView!
    
    var data: [String: [String]] = [:]
    var subviews: [[CellView]] = []
    var origin: CellView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        data = ["map": ["size", "20", "20"]]
        scrollview.isDirectionalLockEnabled = true
        load()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Loading Process
    func load2(){
        
//        let cellView = CellView.instanceFromNib()
//        cellView.label.text = "kk"
//        cellView.label.backgroundColor = UIColor.blue
//        let margin = view.layoutMarginsGuide
//
//        subviews[0].append(cellView)
        
//        view2.backgroundColor = UIColor.blue
//        let margin = view.layoutMarginsGuide
//        view2.leadingAnchor.constraint(equalTo: view1.trailingAnchor, constant: 10)
        
//        self.view.addSubview(subviews[0][0])
//        subviews[0][0].leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
//        subviews[0][0].topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        
        let margin = contentview.layoutMarginsGuide
        
        for i in 1...15 {
            let subView3 = CellView.instanceFromNib()
            subView3.translatesAutoresizingMaskIntoConstraints = false
            
            subviews[0].append(subView3)
            contentview.addSubview(subView3)
            subView3.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 8.0).isActive = true
            subView3.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: 8.0).isActive = true
//            subView3.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
//            subView3.widthAnchor.constraint(equalToConstant: 10000.0).isActive = true
        }
        
        
        let subView3 = subviews[0][0]
        subView3.topAnchor.constraint(equalTo: margin.topAnchor, constant: 8.0).isActive = true
        
        //subviews[0][1].topAnchor.constraint(equalTo: subviews[0][0].bottomAnchor, constant: 25.0).isActive = true

        
        for i in 1...14 {
//            let subView4 =
//            let subView2 = subviews[0][i - 1]
            subviews[0][i].topAnchor.constraint(equalTo: subviews[0][i - 1].bottomAnchor, constant: 20.0).isActive = true
        }
        subviews[0][14].bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: 8.0).isActive = true

        
        
//        subView3.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        subView3.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        subView3.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        subView3.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    }
    
    
    // description 
    // purpose - to display many node on ipad, espicially in a matrix
    // input requirement - or what you really want to know 
    // #1 node -> auto-node
    // #2 style -> auto-position -> shape don't give me and I don't use this .
    // #3 position -> auto-position.... ... ... ... ...
    // #4 animation - default - > auto-animation ..  ... 
    
    
    // layout guide of scroll view
    // cell from nib -> born -> init -> own guide
    // send input to cell -> changes the behavior of cell -> force memory
    // for loop -> write 20 (similar)same thing... parameter of i (sytactic sugar)
    // subview.append -> input to change sate -> for later use
    // add something to map 
    // evetually use the map to represent things as input for layout funtion
    // add -> sometime later -> display -> display a node which is a view (tag:class)
    // also some other change ralated to this data 
    //
    
    func load(){
        

        map()
        
        setframelayout()
        
        addSubviews()
        
        enableCodelayout()
        
        //autolayout()
        
        
        setvalue()
    }
    
    func map(){
        for i in 0...SIZE{
            subviews.append([CellView]())
            for _ in 0...SIZE{
                subviews[i].append(CellView.instanceFromNib())
            }
        }
    }
    
    func addSubviews(){
        for i in 0...SIZE{
            for j in 0...SIZE{
                contentview.addSubview(subviews[i][j])
            }
        }
    }
    
    func enableCodelayout(){
        for i in 0...SIZE{
            for j in 0...SIZE{
                subviews[i][j].translatesAutoresizingMaskIntoConstraints = false
            }
        }
    }
    
    func setframelayout(){
        
        let x0 = 100
        let y0 = 100
        
        let w = 100
        let h = 100
        
        for i in 0...SIZE{
            for j in 0...SIZE{
                subviews[i][j].frame = CGRect(x: x0 + i * (50 + 20), y: y0 + j * (50 + 20), width: w, height: h)
                
            }
        }
        
        
        
        
        
    }
    
    func autolayout(){
        
        nodeAutoLayoutRule()
        
        scrollviewAutolayoutRule()
    }
    
//    trailingAnchor
//    leadingAnchor
//    bottomAnchor
//    topAnchor
    
    func nodeAutoLayoutRule(){
        
        
        // topline layout rule
        
        // #1 set top alignment
        for i in 1...SIZE{
            // top a to top a equal
            subviews[i][0].topAnchor.constraint(equalTo: subviews[0][0].topAnchor, constant: CGFloat(0)).isActive = true

        }
        
        // #2 set gap between each element
        for i in 1...SIZE{
            // top a to top a equal
            subviews[i][0].leadingAnchor.constraint(equalTo: subviews[i - 1][0].trailingAnchor, constant: CGFloat(20)).isActive = true

        }
        
        
        // #3 for each group set a left to left alignment
        for i in 0...SIZE{
            
            let list = subviews[i]
            
            for j in 1...SIZE {
                list[j].leadingAnchor.constraint(equalTo: list[j - 1].leadingAnchor, constant: CGFloat(0)).isActive = true
            }
            
            
        }
        
        // #4 for each group set vertical gap
        for i in 0...SIZE{
            
            let list = subviews[i]
            
            for j in 1...SIZE {
                list[j].topAnchor.constraint(equalTo: list[j - 1].bottomAnchor, constant: CGFloat(20)).isActive = true
            }
            
        }
        
        
        
        
        
    }
    
    func scrollviewAutolayoutRule(){
        let m = contentview.layoutMarginsGuide

        // top
        subviews[0][0].topAnchor.constraint(equalTo: m.topAnchor, constant: CGFloat(20)).isActive = true
        
        // buttom
        subviews[0][SIZE].bottomAnchor.constraint(equalTo: m.bottomAnchor, constant: CGFloat(-20)).isActive = true
        
        // leading
        subviews[0][0].leadingAnchor.constraint(equalTo: m.leadingAnchor, constant: CGFloat(20)).isActive = true
        
        // trailing
        subviews[SIZE][0].trailingAnchor.constraint(equalTo: m.trailingAnchor, constant: CGFloat(-20)).isActive = true
    }
    
    // #5 set map value
    func setvalue(){
        for i in 0...SIZE{
            for j in 0...SIZE{
                subviews[i][j].backgroundColor = UIColor.randomColor()
                subviews[i][j].label.text = "Position:     \(i, j)"
                subviews[i][j].widthAnchor.constraint(equalToConstant: 100).isActive = true
                subviews[i][j].heightAnchor.constraint(equalToConstant: 100).isActive = true
                if (shouldhide(i, j)){
                    subviews[i][j].isHidden = true
                }
            }
        }
    }
    
    func shouldhide(_ a: Int, _ b: Int) -> Bool {
        if (a > 20 || b > 20){
            return true
        } else {
            return false
        }
    }
    
    
    func load_3(){
        
        for x in 0...SIZE{
            subviews.append([CellView]())
            for y in 0...(x + 5){
                let node = CellView.instanceFromNib()
                node.translatesAutoresizingMaskIntoConstraints = false
                subviews[x].append(node)
                contentview.addSubview(node)
            }
        }
        
//        for c in subviews{
//            for s in c{
//                // global - each elemnt keep same distance either up or right
//                // the leftest elemnt aglin with the screen
//                // the best y aglin with the top screen
//                
//                print(s)
//            }
//        }
        
        
        print(1)
        
        var a = 0
        var b = 0
        
        print(2)
        
        let x = 50
        let y = 100
        
        print(3)
        
        let m = view.layoutMarginsGuide
//        self.origin = CellView.instanceFromNib()
//        contentview.addSubview(origin)
//        print(7)
//        origin.topAnchor.constraint(equalTo: m.topAnchor, constant: CGFloat(x)).isActive = true
//        print(6)
//        origin.leadingAnchor.constraint(equalTo: m.leadingAnchor, constant: CGFloat(y)).isActive = true
        
        
        
        print(4)
        
        
        let h = 25.0
        let v = 25.0
        
        // check if there is one point 
        subviews[0][0].topAnchor.constraint(equalTo: m.topAnchor, constant: 0).isActive = true
        subviews[0][0].leadingAnchor.constraint(equalTo: m.leadingAnchor, constant: 0).isActive = true
        
        print(5)
        
        for i in 1...SIZE {
            subviews[i][0].topAnchor.constraint(equalTo: subviews[0][0].topAnchor, constant: 0).isActive = true
            subviews[i][0].leadingAnchor.constraint(equalTo: subviews[i - 1][0].leadingAnchor, constant: CGFloat(h)).isActive = true
            if i == subviews.count {
                subviews[i][0].trailingAnchor.constraint(equalTo: m.trailingAnchor, constant: 0).isActive = true
            }
        }
        print(9)
        
        for c in subviews{
            for s in c{
                // global - each elemnt keep same distance either up or right
                // the leftest elemnt aglin with the screen
                // the best y aglin with the top screen
                if (a > 0){
                    s.leadingAnchor.constraint(equalTo: subviews[0][0].leadingAnchor, constant: 0).isActive = true
                    s.topAnchor.constraint(equalTo: subviews[b][a - 1].topAnchor, constant: CGFloat(v)).isActive = true
                    a += 1
                }
            }
            if (b == 0){
            subviews[0][a].bottomAnchor.constraint(equalTo: m.bottomAnchor, constant: 0).isActive = true
            }
            b += 1
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
