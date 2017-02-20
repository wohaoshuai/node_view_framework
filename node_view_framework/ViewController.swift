//
//  ViewController.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/14/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var database : Database!
    var cache: Cache!
    
    var history = [0]

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        database = appDelegate.database
        cache = appDelegate.cache
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;
        
        
        let types = [1, 2, 3, 4, 5, 6, 7, 8]
        for i in types{
        tableView.register(UINib(nibName:("Cell" + String(i)), bundle:nil), forCellReuseIdentifier: ("Cell" + String(i)))
        }
        
        load_data(id: history[0], rule: "Expand")
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("aixuexi"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.methodOfReceivedNotification2(notification:)), name: Notification.Name("button_touch"), object: nil)
    }
    
    func methodOfReceivedNotification(notification: Notification){
        
        
//        let cell1 = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! TheCell
//        let cell2 = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! TheCell
//        let cell3 = tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! TheCell
//        
//        let id = Int(cell1.read()!)!
//        print(id)
//        let key = cell2.read()!
//        let value = cell3.read()!
//        
//        database.change_data(id: id, key: key, value: value)
    }

    // cell handler - of which a delegation
    func methodOfReceivedNotification2(notification: Notification){
        
        // improve casting here
        let id = (notification.object as! Node).id
        let rule = notification.name.rawValue
        
        print("rawValue ++++")
        print(rule)
        load_data(id: id, rule: "button_touch")
        
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTableView(){
        tableView.separatorStyle = .none

        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        self.tableView.addGestureRecognizer(edgePan)
    }
    
    func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            back()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cache.core_data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        let node = cache.core_data[i]
        let identifier = "Cell" + String(node.type)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TheCell
        cell.update(node: node)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        load_data(id: cache.core_data[indexPath.row].id, rule: "Touch")
    }
    
    @IBAction func back_button_touched(_ sender: UIButton) {
        back()
    }
    
    func load_data(id: Int, rule: String){
        cache.meta_data = [:]
        let results = database.run_query_with_(id: id, rule: rule)
        update_meta_data_with_(results: results)
        update_core_data_with_(results: results)
        update_view(id: id)
        build_map()
    }
    
    func update_meta_data_with_(results: ([Node], [String:String])){
        cache.meta_data = results.1
    }
    
    func update_core_data_with_(results: ([Node], [String:String])){
        if cache.meta_data["core_data"] == "replace"{
            cache.core_data = results.0
        }
    }
    
    func update_view(id: Int) {
        
//        print(id)
//        print(history)
//        print(cache.meta_data)
        
        if cache.meta_data["direction"] == "forward"{
            history.insert(id, at: 0)
            
            UIView.transition(with: self.view, duration: 0.15, options: [.curveEaseIn, .transitionCrossDissolve], animations: { ()-> Void in self.tableView.reloadData()}, completion: nil)
            tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: UITableViewRowAnimation.left)
        }

        if cache.meta_data["direction"] == "backward"{
            history.remove(at: 0)
            load_data(id: history[0], rule: "back_expand")
        }
        
        if cache.meta_data["direction"] == "backed"{
            UIView.transition(with: self.view, duration: 0.15, options: [.curveEaseIn, .transitionCrossDissolve], animations: { ()-> Void in self.tableView.reloadData()}, completion: nil)
            tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: UITableViewRowAnimation.right)
        }
        

        if cache.meta_data["direction"] == "no" {
            tableView.reloadData()
            tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: UITableViewRowAnimation.automatic)
        }
        
        if cache.meta_data["direction"] == "fuck"{
            tableView.reloadData()
        }
    }
    
    func back(){
        if history.count > 1{
            load_data(id: 999, rule: "Back")
        }
    }
    @IBAction func window_button_pushed(_ sender: UIButton) {
        add()
    }
    
    @IBAction func woaixuexi(_ sender: UIButton) {
        load_data(id: 1000, rule: "woaixuexi")
    }
    
    func add(){
        load_data(id: 1000, rule: "add")
        //load_data(id: 1000, rule: "refresh")
        load_current(rule: "display")
    }
    
    func load_current(rule: String){
        load_data(id: history[0], rule: rule)
    }
    
    func build_map(){
        cache.index_table = [:]
        if cache.core_data.count > 0{
            for i in 0...(cache.core_data.count - 1){
                let id = cache.core_data[i].id
                cache.index_table[id] = i
            }
        }
//        print(self.cache.index_table)
    }
}

