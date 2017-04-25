//
//  Rootview.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/24/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit
import Foundation


extension CGRect{
    public static func square(size: Int)->CGRect{
        return CGRect(x: 0, y: 0, width: size, height: size)
    }
}

enum NVColor:String{
    case barButton = "F7F7F7"
    case bar = "E9E5E5"
    case block = "2D2D2D"
    case googleBlue = "4179F7"
    case white = "FFFFFF"
    case black = "000000"
}

extension UIIView {
    
    // MARK: - Size Class
    func treatAsRectview(){
        self.customList.append(NVCustom.depend("contentSize", "frame", NVFunction.atomic(["equal"])))
    }
    
    // MARK: - AnimationKit
    
    
    // MARK: - TransitionKit
    indirect enum NVTransition{
        case enableStackLayout
        case popWindow(String)
        case enableTracking
        case removeWithTag(Int)
        case removeModalView
        case dismissFirst
        case run
    }
    
    struct NVFontSize {
        static let title = CGFloat(23)
    }
    
    func installMainCell(key: String,value: [(String, String)])->UIIView{
        let container = installModalView()
        
        //var functionList : [String: [(String, String)]] = ["MyClass.static_test": [("i", "Int")]]

        container.backgroundColor = UIColor.white
        container.layer.cornerRadius = 6
        container.installLevelOneShadow()
        //container.frame.size = CGSize(width: 300, height: 400)
        container.updateThroughCustom(form: NVCustomForm.update("frame", CGRect(origin: container.frame.origin, size:  CGSize(width: 300, height: 400))))
        
        
        
        // create a large block on top 
        let top = container.installModalView()
        top.frame.size = container.frame.size
        top.frame.size.height = 90
        top.clipsToBounds = true
        top.contentSize = top.frame.size

        container.handleRequest(sender: top, request: UIView.Request.keepLeft(0))
//        container.handleRequest(sender: top, request: UIView.Request.keepRight(0))
        container.handleRequest(sender: top, request: UIView.Request.keepTop(0))
        
        top.backgroundColor = NVColor.googleBlue.rawValue.hexColor
        
        // create a label inside of block
        let label = top.installSubviewLabelClean()
        label.text = key
        label.textColor = UIColor.white
        label.font = label.font.withSize(NVFontSize.title)
        label.sizeToFit()
        top.handleRequest(sender: label, request: UIView.Request.keepLeft(10))
        top.handleRequest(sender: label, request: UIView.Request.keepTop(10))
        
        
       // let data = TableViewData()
        // create view from dataset 
        container.bounds.size.height = top.frame.height + CGFloat(value.count) * CGFloat(50)
        handleRequest(sender: container, request: UIView.Request.keepTop(100))
        handleRequest(sender: container, request: UIView.Request.keepLeft(23))
        container.tap_enable()
        container.transition = NVTransition.run
        
        // set new top margin 
        let newOriginY = top.frame.height
        let newOriginX = CGFloat(0)
        
        // display 3 colum group
        for (c1, c2) in value{
            
            
            let row = container.installModalViewWith(width: Double(container.frame.width), height: 50)
            row.frame.origin.x = newOriginX
            row.frame.origin.y = newOriginY
            row.backgroundColor = UIColor.clear
            //row.layer.borderWidth = 1
            //row.layer.borderColor = UIColor.orange.cgColor
            
            let columns = row.installHorizontalCell(n: 3)
            
            let label0 = columns[0].installSubviewLabelClean()
            columns[0].handleRequest(sender: label0, request: UIView.Request.full)
            label0.text = c1
            //label0.backgroundColor = UIColor.red
            
            print(label0.text)
            
            let label1 = columns[1].installSubviewLabelClean()
            columns[1].handleRequest(sender: label1, request: UIView.Request.full)
            print(label1.frame)
            print(columns[1].frame)
            label1.text = c2
            //label1.backgroundColor = UIColor.red

            
            let label3 = columns[2].installSubviewTextClean()
            columns[2].handleRequest(sender: label3, request: UIView.Request.full)
            print("label3")
            print(label3.frame)
            print(columns[2].frame)
            label3.placeholder = "Enter"
            //label3.backgroundColor = UIColor.green

        }
        
        addSubview(container)
        return container
    }
    
    func installHorizontalCell(n : Int)->[UIIView]{
        if (n < 1) {return [UIIView]()}
        
        let w = CGFloat(frame.width) / CGFloat(n)
        let h = frame.height
        var x : CGFloat = 0
        var y : CGFloat = 0
        
        let l = frame.width - CGFloat(n) * w // special width factor
        
        var res :[UIIView] = []
        for i in 1...n{
            let modal = installModalViewWith(width: Double(w), height: Double(h))
            modal.frame.origin.x = CGFloat(x)
            modal.frame.origin.y = CGFloat(y)
            modal.backgroundColor = UIColor.clear
            modal.layer.borderWidth = 0.25
            modal.layer.borderColor = UIColor.lightGray.cgColor//NVColor.googleBlue.rawValue.hexColor.cgColor
            
            // culmulative
            x += w
            res.append(modal)
            addSubview(modal)
        }
        return res
    }
    
    func removeWithTag(int: Int){
       // todo
    }
    
    func removeModalView(){
        //move_with_animation(x: 100, y: 100)
        postNotification(title: "removeModal")
    }
    
    func dismissFirst(){
        postNotification(title: "dismissFirst")
    }
    
    func takeTransition(transition: NVTransition){
        switch transition {
        case .enableStackLayout:
            enableStackLayout()
        case .popWindow(let v): // string as parameter of the window config
            postNotification(title: "global")
        case .enableTracking:
            enableTraking()
        case .removeWithTag(let tag):
            removeWithTag(int: tag)
        case .removeModalView:
            removeModalView()
        case .dismissFirst:
            dismissFirst()
        case .run:
            run()
        default:
            print("\(transition) not yet in takeTransition >_<")
        }
    }
    
    func enableTraking(){
        print("tap_traking_enable")
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapTraking(sender:)))
        self.addGestureRecognizer(tap)
        tap.isEnabled = true
    }
    
    func handleTapTraking(sender: UITapGestureRecognizer){
        print("handleTapTraking....")
        print(sender.location(in: self))
        if sender.state == .ended{
            postNotification(title: "tapTraking", obj: nil)
        }
    }
    
    func run(){
        print("run...")
        let classname = "UIView"
//        
//        if let c = NSClassFromString(classname) as? NSObject{
//            print("oh ..")
//            let c_tmp = c.init()
//            c_temp.perfrom(Selector())
//            c.perfrom(Selector())
//        }
//        NSClassFromString(classname)?.perform(#
//zSelector("static_test"), with: "Wowo!")
  //      let k = NSClassFromString(classname) as! NSObject
        
        let cellClass: AnyClass! = NSClassFromString(classname)
        var objectType : NSObject.Type! = cellClass as! NSObject.Type!
        var theObject: NSObject! = objectType.init()// as! NSObject
        //var myCell:UIView = theObject as! UIView
        //myCell.test()
        theObject.perform(Selector("testt:"), with: "1")
        //k.perform(Selector("static_test"))
    }
    
    func enableStackLayout(){
        let view = superview! as! UIIView
        view.layoutPolicy = LayoutPolicy.stack(LayoutStack())
        view.layoutSubviews2()
    }
    
    // MARK: - TouchKit
    func tap_enable(){
        print("tap_enable")
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tap)
        tap.isEnabled = true
    }
    
    func handleTap(sender: UITapGestureRecognizer){
        print("handleTap")
        if sender.state == .ended{
            takeTransition(transition: transition)
        }
    }
    
    func moveViewToCenter(view: UIView){
        view.center = self.center
    }
    
    // MARK: - WindowKit
//    func treatAsTableView() {
//        print("Under Construction...")
//    }
}


extension UIView {


    // MARK: - CGKit
    indirect enum CGFrameReplace {
        case width(CGFloat)
        case height(CGFloat)
        case x(CGFloat)
        case y(CGFloat)
        case size(CGFloat, CGFloat)
        case origin(CGFloat, CGFloat)
    }
    
    func replaceFrame(sender: UIView, rule: CGFrameReplace){
        var origin = CGPoint(x: 0, y: 0)
        var size = CGSize(width: 0, height: 0)
        
        switch rule {
        case .x(let v):
            size.width = sender.frame.size.width
            size.height = sender.frame.size.height
            origin.x = CGFloat(v)
            origin.y = sender.frame.origin.y
            sender.frame = CGRect(origin: origin, size: size)
        case .y(let v):
            size.width = sender.frame.size.width
            size.height = sender.frame.size.height
            origin.x = sender.frame.origin.x
            origin.y = CGFloat(v)
            sender.frame = CGRect(origin: origin, size: size)
        case .width(let v):
            size.width = CGFloat(v)
            size.height = sender.frame.size.height
            origin.x = sender.frame.origin.x
            origin.y = sender.frame.origin.y
            sender.frame = CGRect(origin: origin, size: size)
        case .height(let v):
            size.width = sender.frame.size.width
            size.height = CGFloat(v)
            origin.x = sender.frame.origin.x
            origin.y = sender.frame.origin.y
            sender.frame = CGRect(origin: origin, size: size)
        default:
            print("Error: replaceFrame rule not found")
            print("Meta: \(rule)")
        }
        
    }
    
    // MARK: - RequestKit
    indirect enum Request{
        case fixWidth
        case fixHeight
        case keepLeft(Double)
        case keepRight(Double)  // okay!
        case keepTop(Double)
        case keepBottom(Double)
        case leftmost
        case rightmost
        case center
        case centerX
        case centerY
        case keepCenter
        case and([Request])
        case or([Request])
        case report(Request)
        case full
    }
    
    func test(t: String){
        print("Greeting From UIView 2017-02-28 13:03:53 Bedroom.Desk.Macbook-Air 1-21-C 15 Jiangxi St. Chengdu, China, Earth")
        print(t)
    }
    
    func handleRequest(sender: UIView, request: Request){
        switch request {
        case .keepRight(let x):
            let newX = frame.size.width - sender.frame.size.width - CGFloat(x)
            let rule = CGFrameReplace.x(newX)
            replaceFrame(sender: sender, rule: rule)
        case .keepLeft(let x):
            let newX = x
            let rule = CGFrameReplace.x(CGFloat(newX))
            replaceFrame(sender: sender, rule: rule)
        case .keepTop(let y):
            let newY = y
            let rule = CGFrameReplace.y(CGFloat(y))
            replaceFrame(sender: sender, rule: rule)
        case .keepBottom(let y):
            let newY = frame.size.height - sender.frame.size.height - CGFloat(y)
            let rule = CGFrameReplace.y(CGFloat(y))
            replaceFrame(sender: sender, rule: rule)
        case .keepCenter():
            sender.center = self.convert(self.center, from: superview!)
            print(sender.center)
        case .centerY:
            sender.center.y = self.convert(self.center, from: superview!).y
        case .centerX:
            sender.center.x = self.convert(self.center, from: superview!).x
        case .full:
            let margin = CGFloat(3)
            sender.frame.origin.x = margin
            sender.center.y = self.frame.height / 2
            sender.frame.size.width = self.frame.size.width - 2 * margin
            //sender.frame.size.height = self.frame.size.height - 2 * margin

        default:
            print("Error: handleRequest request not found")
            print("Meta: \(request)")

        }
    }
    
    // MARK: - QuartKit
    
    func installShadow() {
        layer.cornerRadius = 2
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.7
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowRadius = 3.0
     
    }
    
    func installLevelOneShadow(){
        layer.cornerRadius = 5
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.8
        // layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowRadius = 5.0
    }
    
    func installCellOne(){
        let container = installModalView()
        
    }
    
    func addgradian(t: UIView, s: String, e: String){
        let gl =  TopDownGradientLayer(view: t, s: s, e: e)
        t.layer.insertSublayer(gl, at: 0)
    }
    
    func installInnerShadow() {
        
        backgroundColor = UIColor.clear
        
        let top = NVTopGradientLayer(view: self)
        let bottom = NVBottomGradientLayer(view: self)
        let trailing = NVTrailingGradientLayer(view: self)
        let leading = NVLeadingGradientLayer(view: self)
        
        layer.insertSublayer(leading, at: 0)
        layer.insertSublayer(top, at: 0)
        layer.insertSublayer(bottom, at: 0)
        layer.insertSublayer(trailing, at: 0)
    }
    
    // MARK: - LayoutKit
    func insertSubviewHorizontal(view: UIView, left: Double, right: Double){
        let top = 5.0
        
        let l = CGFloat(left)
        let r = CGFloat(right)
        let w = view.frame.width
        
        let newWidth = l + w + r
        
        let newSize = CGSize(width: newWidth, height: self.frame.height)
        self.frame = CGRect(origin: self.frame.origin, size: newSize)
        
        let newOrigin = CGPoint(x: left, y: top)
        
        self.addSubview(view)
        view.frame = CGRect(origin: newOrigin, size: view.frame.size)
    }
    
    // MARK: - StyleKit
    func addButtonStyle(){
        layer.cornerRadius = 5
        //installInnerShadow()
    }

    

    
    // MARK: - SubviewKit
    // MARK: Useful Subview
    
    func installSubviewText()->UITextField{
        let view = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        self.insertSubviewHorizontal(view: view, left: 5, right: 5)
        view.borderStyle = UITextBorderStyle.none
        view.textColor = "546B86".hexColor
        view.text = "Enter"
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func installSubviewTextClean()->UITextField{
        let view = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        view.borderStyle = UITextBorderStyle.none
        view.textColor = UIColor.black
       // view.text = "Enter"
        
        addSubview(view)
        //view.backgroundColor = UIColor.clear
        return view
    }
    
    func installSubviewLabel()->UILabel{
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: 65, height: 30))
        insertSubviewHorizontal(view: view, left: 5, right: 5)
        view.textColor = UIColor.white
        //view.backgroundColor = "4682BC".hexColor
        return view
    }
    
    func installSubviewLabelClean()->UILabel{
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: 65, height: 30))
        view.textColor = UIColor.black
        view.text = ">_<"
        
        // experimental
        
        addSubview(view)
        return view
    }
    
    
    // MARK: - Munual Layout Tool
    
    
    func adjustSizeByRatio(r: Double){
        
    }
    
    func adjustWidthByValue(x: Double){
        
    }
    
    func adjustHeightByValue(x: Double){
        
    }
    
    func installSubviewButton()->UIIView{
        let button = createSubviewScroll()
        let origin = CGPoint(x: 820, y: 24)
        let size = CGSize(width: 78, height: 40)
        
        button.backgroundColor = UIColor.blue//UIColor.clear
        button.layer.cornerRadius = 5
        
        button.frame = CGRect(origin: origin, size: size)
        button.contentSize = button.frame.size //!
        
        addSubview(button)
        handleRequest(sender: button, request: Request.keepRight(350))
        return button
    }
    
    
    
    func installBlockingView()->UIIView{
        let alpha = 0.7
        let color = NVColor.black
        
        let frame = self.frame
        let view = UIIView(frame: frame)
        view.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
        postNotification(title: "push")
        self.addSubview(view)
        
        
        view.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {view.alpha = 1})
        
        return view
    }

    
    // MARK:  Abstract Subviews
    func createSubviewScroll()->UIIView{
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: 100, height: 100)
        let scrollview = UIIView(frame: frame)
        scrollview.backgroundColor = UIColor.white
        return scrollview
    }
    
    enum NVHeight: Int{
        case toolbar = 65
        case modal = 600
        case popup = 250
    }
    
    
    // MARK: - Build Google View
    
    func move_with_animation(x: Int, y :Int){
        let newCenter = CGPoint(x: self.center.x + CGFloat(x), y: self.center.y + CGFloat(y))
        UIView.animate(withDuration: 1.0, animations: {()->Void in self.center = newCenter})
    }
    
    //
    func installGoogleView()->UIIView{
        
        // view 1
        installBlockingView()
        
        // view 2
        let container = installModalView()
        let topbar = container.installModalView()
        let size = container.bounds.size
        
        container.installShadow()
        
        // view 3
        topbar.frame = CGRect(x: 0, y: 0, width: size.width, height: CGFloat(NVHeight.toolbar.rawValue))
        topbar.backgroundColor = ((NVColor.googleBlue.rawValue) as! String).hexColor
        //topbar.installShadow1()
        topbar.enableTraking()
        
        container.layer.cornerRadius = 10
        container.clipsToBounds = true
        
        // View 4
        let label = topbar.installSubviewLabelClean()
       // handleRequest(sender: label, request: UIView.Request.keepLeft(15))
        topbar.handleRequest(sender: label, request: UIView.Request.keepCenter)
        
        let cancel = topbar.installSystemButton(text: "Cancel")
        cancel.tap_enable()
        cancel.transition = UIIView.NVTransition.dismissFirst
        
        container.center.y += CGFloat(900)
        container.alpha = 0
        
        UIView.animate(withDuration: 0.35, animations: {container.center.y -= CGFloat(900)})
        UIView.animate(withDuration: 0.35, animations: {container.alpha = 1})
        UIView.animate(withDuration: 0.15, delay: 0.35, usingSpringWithDamping: CGFloat(0.8), initialSpringVelocity: CGFloat(0.5), options: UIViewAnimationOptions.allowAnimatedContent, animations: {}, completion: nil)
        return container
    }
    
    func dismissGoogleView(){
        postNotification(title: "dismissFirst")
    }
    
    
    func installSystemButton(text: String)->UIIView{
        let button = installModalView()
        
        let rect = CGRect.square(size: 40)
        print("new rect: \(rect)")
        button.updateThroughCustom(form: NVCustomForm.update("frame", rect))
        
        handleRequest(sender: button, request: UIView.Request.keepLeft(10))
        handleRequest(sender: button, request: UIView.Request.centerY)
        button.backgroundColor = UIColor.white
        //handleRequest(sender: label, request: UIView.Request.keepCenter)
        addSubview(button)
        return button
    }
    
    func installModalViewWith(width: Double, height: Double)->UIIView{
        let modal = installModalView()
        modal.frame.size.width = CGFloat(width)
        modal.frame.size.height = CGFloat(height)
        modal.contentSize = modal.frame.size
        modal.backgroundColor = UIColor.white
        return modal
    }
    
    func installModalView()->UIIView{
        let container = createSubviewScroll()
        container.treatAsRectview() // new
        
        let rect = CGRect(x: 200, y: 200, width: 500, height: 500)
        container.updateThroughCustom(form: NVCustomForm.update("frame", rect)) // new
        
    
        
        self.addSubview(container)

        
        //container.center = (superview!).center
        // under construct
        
        // what I didn't do that is necessary for display a reasonable veiw
        // what I suggest as the good way of using it as
        
        return container
    }

    
    // MARK:- Notification Kit
    func postNotification(title: String){
        NotificationCenter.default.post(name: Notification.Name(title), object: nil)
    }
    
    func postNotification(title: String, obj: Any?){
        NotificationCenter.default.post(name: Notification.Name(title), object: obj)
    }
    
    // MARK: - Image Kit 
    func installImageView(image: UIImage?, highlightedImage: UIImage?){
        let view = UIImageView(image: image, highlightedImage: highlightedImage)
    }
    
    
    /** MARK: - View Setup Checklist
     1.Specify View Type
     2.Run Install Program
     3.Custom the View
     **/
}

extension String {
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

//struct NVLayoutContraint{
//    var
//}

class TableViewData: NSObject {
    var datasoure: [Any]?
    var data: [[Int]] = []
    var gap: Double = 0
    var sectionNum: Int {
        get {
            return data.count
        }
    }
}

class Rootcontrol: UIViewController {
    
    // Fake database
    var functionList : [String: [(String, String)]] = ["MyClass.static_test": [("i", "Int")]]
    
    // MARK: - new version
    // windows -- collection of rootview's sibling views, system level #000
    var windows = [NVView]()
    var fullscreen = [UIView]()
    
    // MARK: - old version
    // old prototype
    var paper: UIIView!
    var topbar: UIIView!
    var toolkit: [UIScrollView] = []
    
    var boolmap: [[Bool]] = []
    var idmap: [[Int]] = []
    let w = 100 * 1.2
    let h = 100 * 1.2
    let x = 40.0 // origin
    let y = 40.0
    let n = 6  // map size
    let m = 100
    let gx = 20.0
    let gy = 20.0
    
    var fliped = false
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        paper.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        var red = CGFloat(109 / 255.0)
        var green = CGFloat(109 / 255.0)
        var blue = CGFloat(109 / 255.0)
        var alpha = CGFloat(1.0)
        
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        // this should be excuted frist
        
        //settoolbar()
        
        loadsubviews()
        
        
        // your code here 
        
        startObserving()
        //view.installBlockingView()
        let button = topbar.installSubviewButton()
        button.tap_enable()
        
        installMainCellTable()
        // your code end
    }
    
    
    func createMap() {
        for i in 0...n{
            boolmap.append([])
            for j in 0...m{
                boolmap[i].append(true)
            }
        }
        
        
        for i in 0...n{
            idmap.append([])
            for j in 0...m{
                idmap[i].append(-1)
            }
        }

        for i in 0...n{
            for j in 0...m{
                if boolmap[i][j] == true{
                    let start_x = x + Double(i) * (w + gx)
                    let start_y = y + Double(j) * (h + gy)
                    if i == 0{
                        createblock(x: Int(start_x), y: Int(start_y), text: "Drag Here.", type: 1)
                        
                    } else {
                        createblock(x: Int(start_x), y: Int(start_y), text: "\(i, j)", type: 2)
                    }
                }
            }
        }
        
        // reset scroll view size 
//        let w0 = x * 2 + w * n + gx * (n - 1);
//        let h0 = y * 2 + h * m + gy * (m - 1);
      //  paper.frame = CGRect();
        
//        idmap[0][0] = paper.subviews.count
//        boolmap[0][0] = true
//        createblock(x: 40, y: 40, text: "Add New Block")
        
        let total_gap_x = gx * Double(n + 1)
        let total_gap_y = gy * Double(m + 1)
        
        let total_block_x = w * Double(n + 1)
        let total_block_y = h * Double(m + 1)
        
        let margin_x = 2 * x
        let margin_y = 2 * y
        
        
        // update it
        let aframe = CGSize(width: total_gap_x + total_block_x + margin_x, height: total_gap_y + total_block_y + margin_y)
        
        paper.contentSize = aframe
        paper.contentMode = UIViewContentMode.bottom
        paper.setNeedsDisplay()
        // try to handle a event 

        //paper.subviews[0].addGestureRecognizer(tap)
        //(paper.subviews[0] as! NVView).tap_enable()
        
        
        
    }
    
//    func handleTap(){
//        print("hello")
//        flip_select()
//    }
//    
//    func flip_select(){
//        if fliped == true {
//            backnormal(block: paper.subviews[0])
//        } else {
//            highlight(block: paper.subviews[0])
//        }
//        fliped = !fliped
//    }
//    
//    func highlight(block: UIView){
//                let red = CGFloat(74 / 255.0)
//                let green = CGFloat(193.0 / 255.0)
//                let blue = CGFloat(226.0 / 255.0)
//                let alpha = CGFloat(61.0 / 255.0)
//                block.layer.shadowColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
//                block.layer.shadowOpacity = 1
//                block.layer.shadowRadius = 4
//                block.layer.shadowOffset = CGSize(width: 0, height: 0)
//                block.layer.shouldRasterize = true
//                block.layer.rasterizationScale = 2.0
//    }
//    
//    func backnormal(block: UIView){
//        let red = CGFloat(167 / 255.0)
//        let green = CGFloat(180.0 / 255.0)
//        let blue = CGFloat(195.0 / 255.0)
//        let alpha = CGFloat(1.0)
//        
//        block.layer.shadowColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
//        block.layer.shadowOpacity = 0.9
//        block.layer.shadowRadius = 3
//        block.layer.shadowOffset = CGSize(width: 2, height: 1)
//    }
//
    
    /**
        - frame position (start point, size) ----|
       1 - frame type ------------------------------> init typed frame
          (depend on init)
       2 - scrollview size (width, height) ----> type based state change
       2 - (indicator, scrolldirection, multipletouch, etc.. open automic, background color)             scrollview detail configuration [scrollview]
       3 - push frame to main display
       4 - layout subviews
       
     
       [core color]
       --- create color from 0 to 255 + (0 - 1) map
       --- return [uicolor] [cgcoclor]
     
     
    **/
    
    // MARK: - Current Core
    func loadsubviews() {
        
        setmainview()
        loadbarview()
        view.addSubview(topbar)
        
        let button = loadbutton()
        button.installSubviewText()
        topbar.addSubview(button)
        topbar.addButtonStyle()
        
        let button2 = topbar.installSubviewButton()
//
//        // new label
//        let label = button2.installSubviewLabel()
//        label.text = "Hello"
//        topbar.layoutSubviews2()
//        
//        let button3 = topbar.installSubviewButton()
        button2.tap_enable()
    }
    
    
    // MARK: - Old Version 2!!!
    func loadbutton()->UIView{
        
        let button = loadscrollview()
        let origin = CGPoint(x: 820, y: 24)
        let width = view.frame.width
        let size = CGSize(width: 78, height: 40)

        button.frame = CGRect(origin: origin, size: size)
        button.contentSize = button.frame.size
        button.backgroundColor = UIColor.yellow
        button.addButtonStyle()
        
        return button
    }
    
    func loadbarview(){
        topbar = loadscrollview()
        barview_final()
    }
    
    func barview_final(){
        let origin = CGPoint(x: 0, y: 0)
        let width = view.frame.width
        let size = CGSize(width: width, height: 72)
        topbar.frame = CGRect(origin: origin, size: size)
        topbar.contentSize = topbar.frame.size // relation not once
        
        topbar.backgroundColor = UIColor.clear
        
//        topbar.layer.borderWidth = CGFloat(1.0)
//        topbar.layer.borderColor = "979797".hexColor.cgColor
        
        //topbar.layer.cornerRadius = 5.0
        addgradian(t: topbar, s: "E9E5E5", e: "DDDDDD")
        
//        let shadowl = CALayer()
//        shadowl.shadowColor = "271C1C".hexColor.cgColor
//        shadowl.shadowOpacity = 1.0
//        shadowl.shadowRadius = 4.0
//        shadowl.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        shadowl.frame = topbar.bounds
//        print(shadowl.frame)
//        topbar.layer.insertSublayer(shadowl, at: 0)
        
        topbar.installShadow()
//        topbar.layer.shadowColor = UIColor.black.cgColor
//        topbar.layer.shadowOpacity = 1.0
//        topbar.layer.shadowRadius = 4.0
//        topbar.layer.shadowPath = UIBezierPath(roundedRect: topbar.bounds, cornerRadius: 5.0).cgPath
       //  NVLeadingGradientLayer(view: block)
        
//        block
        
    }
    
    // start color and end color
    func addgradian(t: UIView, s: String, e: String){
        let gl =  TopDownGradientLayer(view: t, s: s, e: e)
        t.layer.insertSublayer(gl, at: 0)
    }
    
    func loadscrollview()->UIIView{
        // we always use fake data to show the possibility
        var size = CGSize(width: 1000, height: 1000)
        var origin = CGPoint(x: 0, y: 0)
        
        var contentSize =  CGSize(width: 1000, height: 1000)
        var showsVerticalScrollIndicator = true
        var showsHorizontalScrollIndicator = true
        var isDirectionalLockEnabled = false
        var isMultipleTouchEnabled = false
        var backgroundColor = UIColor.white
        
        var frame =  CGRect(origin: origin, size: size)
        var scrollview = UIIView(frame: frame)
        
        
        return scrollview
    }
    
    

    
    
    func setmainview(){
        
        //1
        var size = view.frame.size
        var frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        paper = UIIView(frame: frame)
        
        //2
        paper.contentSize = CGSize(width: size.width, height: 1400)
        paper.showsVerticalScrollIndicator = true
        paper.showsHorizontalScrollIndicator = true
        paper.isDirectionalLockEnabled = false
        paper.isMultipleTouchEnabled = false
        paper.backgroundColor = UIColor.white
        
        
        //3
        view.addSubview(paper)
        
        
        
        
//        var red = CGFloat(230.0 / 255)
//        var green = CGFloat(230.0 / 255)
//        var blue = CGFloat(230.0 / 255)
//        var alpha = CGFloat(1.0)
        
        //UIColor(red: 241, green: 241, blue: 241, alpha: 1.0)
        //paper.subviews
    }
    
    
    // subview -> block view
    // know nothing but create block
    
    // outsourcing
    // frame
    
    // size (double, double)  --- > decide by layout protocol not data --> think about moving to another layer 
    // think about how data would drive a ui --> by sending search query 
    // but ui may not usually drive data --> as ui the final representation of data and model
    // mutli devedive ui... and data -> ui is hard data is easy... send layout guide -> not hard -> time is a challenge and security = network
    
    // origin   ----> delegate to controller -----> handle this require a global scoop (layout rule, all block size and so on) --> may give question to other controller who owns data
    
    // create nvview to local data ware house -> state of the view and its internal logic 
    // shadow color is control to take the shadow -> shadow is a element for ui shape layout 
    //
    
    func createblock(x: Int, y: Int, text: String, type: Int){
        
        // set frame -> frame is a independen data block --> conbime many data use catagory tree ---> static
        var origin = CGPoint(x: x, y: y)
        var size = CGSize(width: 100 * 1.2, height: 100 * 1.2)
        var frame = CGRect(origin: origin, size: size)
        var block = NVView(frame: frame)
        
        
        
        
        let blockcolor = UIColor.white
        
        
        let shadowcolor = UIColor(red: CGFloat(240.0 / 255.0), green: CGFloat(240.0 / 255.0), blue: CGFloat(240.0 / 255.0), alpha: 1.0)
        
        
        // color object - part of the config
        var red = CGFloat(254.0 / 255)
        var green = CGFloat(254.0 / 255)
        var blue = CGFloat(254.0 / 255)
        var alpha = CGFloat(1.0)
        //block.layer.cornerRadius = CGFloat(9.0)
        
        
       
        
// outdate way for shadow
//        let layer = CAGradientLayer()
//        layer.startPoint    = CGPoint(x: 0.5, y: 0.0)
//        layer.endPoint      = CGPoint(x: 0.5, y: 1.0)
//        //layer.colors        =CGPoint(0.5, 1.0);
//        layer.colors        = [UIColor(white: 0.1, alpha: 1.0).cgColor, UIColor(white: 0.1, alpha: 0.5).cgColor, UIColor.clear.cgColor]
//        layer.locations     = [0.05, 0.2, 1.0 ]
//        layer.frame         = CGRect(x: 0, y: 0, width: block.frame.width, height: 20)
        
        // control view cache behavior --> performance layer / local layer -> actually global
        block.layer.shouldRasterize = true
        block.layer.rasterizationScale = 2.0

        // control ui style -> specific more detail / still data independent
        if (type == 2){
            block.backgroundColor = UIColor.clear

            let top = NVTopGradientLayer(view: block)
            let bottom = NVBottomGradientLayer(view: block)
            let trailing = NVTrailingGradientLayer(view: block)
            let leading = NVLeadingGradientLayer(view: block)
            
            block.layer.insertSublayer(leading, at: 0)
            block.layer.insertSublayer(top, at: 0)
            block.layer.insertSublayer(bottom, at: 0)
            block.layer.insertSublayer(trailing, at: 0)
            // block.layer.insertSublayer(TopDownGradientLayer(view: block,  s: "FF2525", e: "66FFC5"), at: 0)
        } else {
            block.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            
            red = CGFloat(167 / 255.0)
            green = CGFloat(180.0 / 255.0)
            blue = CGFloat(195.0 / 255.0)
            alpha = CGFloat(1.0)
    
            block.layer.shadowColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
            block.layer.shadowOpacity = 0.9
            block.layer.shadowRadius = 3
            block.layer.shadowOffset = CGSize(width: 2, height: 1)
        }
        block.setNeedsDisplay()

        

       
//        red = CGFloat(167 / 255.0)
//        green = CGFloat(180.0 / 255.0)
//        blue = CGFloat(195.0 / 255.0)
//        alpha = CGFloat(1.0)
//        
//        block.layer.shadowColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
//        block.layer.shadowOpacity = 0.9
//        block.layer.shadowRadius = 3
//        block.layer.shadowOffset = CGSize(width: 2, height: 1)
        
        
        //        red = CGFloat(74 / 255.0)
        //        green = CGFloat(193.0 / 255.0)
        //        blue = CGFloat(226.0 / 255.0)
        //        alpha = CGFloat(61.0 / 255.0)
        //        block.layer.shadowColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
        //        block.layer.shadowOpacity = 1
        //        block.layer.shadowRadius = 4
        //        block.layer.shadowOffset = CGSize(width: 0, height: 0)
        //        block.layer.shouldRasterize = true
        //       block.layer.rasterizationScale = 2.0
        
        
        // layer 3 subview
        paper.addSubview(block)
        // todo : multi touch in selection view
        
        
        
        // non block writing with auto completion
        // vim xcode auto completion support
        
        
        // text view specifation - > micro layout control by applying global request set
        // data indepent layout guide
        let textview = create_textfield()
        block.addSubview(textview)
        autolayout_excpettop(superview: block, subview: textview, x0: 8, y0: 8, z0: 8)
        textview.text = text
        textview.numberOfLines = 6
        textview.textColor = UIColor.black
    }
    
    func create_textfield()->UILabel{
        return UILabel(frame:  CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(50), height: CGFloat(50)))
    }
    
    // global layout control --> need basic layout information ->> may need to aggregate through other layer
    func autolayout_excpettop(superview: UIView, subview: UIView, x0: Int, y0: Int, z0: Int){
        let h = superview.frame.height - subview.frame.height
        subview.frame = CGRect(x: CGFloat(x0), y: h - CGFloat(y0), width: superview.frame.width - CGFloat(x0) - CGFloat(z0), height: subview.frame.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:- Key Function
    


    // MARK: - Archive
    var block: UIView!
    var button: UIView!
    var screen: UIScrollView!
    
    func test(){
        let frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        block = UIView(frame: frame)
        block.backgroundColor = UIColor.red
        view.addSubview(block)
        
        block.frame = CGRect(x: 500, y: 200, width: 100, height: 100)
        
        let bf = CGRect(x: 100, y: 100, width: 100, height: 100)
        button = UIButton(frame: bf)
        button.backgroundColor = UIColor.red
        view.addSubview(button)
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
//        button.addGestureRecognizer(tap)
        
        let sf = CGRect(x: 100, y: 300, width: 300, height: 600)
        screen = UIScrollView(frame: sf)
        screen.backgroundColor = UIColor.blue
        screen.contentSize = CGSize(width: 1500, height: 1500)
        view.addSubview(screen)
    }
    

    
    func addLabel(view: UIView){
        let superview = block
        let subview = UILabel()
        subview.text = "Hello Node"
        subview.textColor = UIColor.black
        superview!.addSubview(subview)
        
        let frame = CGRect(x: 150, y: 150, width: 100, height:50)
        subview.frame = frame
        
        subview.frame = CGRect(x: 0, y: 0, width: 100, height:50)
        subview.setNeedsDisplay()
        
    }
    
    func push_shade(){
        
    }
    
    // MARK:- Notification Handle
    func startObserving(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("push"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.installGlobalModalViewHandler(notification:)), name: Notification.Name("global"), object: nil)
        //addObserver(title: "tapTraking", handler: #selector(self.tapTraker(n:)), obj: nil)
        addObserver(title: "removeModal", handler: #selector(self.removeModal(notification:)), obj: nil)
        addObserver(title: "dismissFirst", handler: #selector(self.dismmisFirst(notification:)), obj: nil)
    }
    
    func removeModal(notification: Notification){
        print("removeModel")
        view.subviews.last!.move_with_animation(x: 100, y: 100)
//        view.subviews.last!.removeFromSuperview()
//        view.subviews.last!.removeFromSuperview()
    }
    
    func dismmisFirst(notification: Notification){
        // view.subviews.last!.move_with_animation(x: 100, y: 100)
        // view.subviews.last!.removeFromSuperview()
        //        view.subviews.last!.removeFromSuperview()
        let size = view.subviews.count
        let container = view.subviews.last!
        let background = view.subviews[view.subviews.count - 2]
        
        func completion(f: Bool){
             view.subviews.last!.removeFromSuperview()
            view.subviews.last!.removeFromSuperview()
        }
        
        UIView.animate(withDuration: 0.35, animations: {container.center.y += CGFloat(900)})
        UIView.animate(withDuration: 0.35, animations: {background.alpha = 0})
        UIView.animate(withDuration: 0.5, animations: {container.alpha = 0}, completion: completion)
    }
    
    
    
    func addObserver(title: String, handler: Selector, obj: Any?){
        NotificationCenter.default.addObserver(self, selector: handler, name: Notification.Name(title), object: obj)
    }
    
    func installGlobalModalViewHandler(notification: Notification){
        view.installGoogleView()
    }
    
    func methodOfReceivedNotification(notification: Notification){
        
    }
    
    //var functionList : [String: [(String, String)]] = ["MyClass.static_test": [("i", "Int")]]

    func installMainCellTable(){
        
        let data = TableViewData()
        for (key, values) in functionList{
            let mainCell = paper.installMainCell(key: key, value: values)
            //mainCell.alpha = 0
            //UIView.animate(withDuration: 1.0, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.allowUserInteraction, animations: {()->Void in mainCell.alpha = 1}, completion: nil)
        }
        
        // create view from dataset
        
    }
    
    
}
