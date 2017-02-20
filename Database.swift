//
//  Database.swift
//  node_view_framework
//
//  Created by Kelong Wu on 2/15/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//

import Foundation

class Database {
    var nodes: [Node] = []
    
    init(){
        addNode(id: 0, type: 0, data: [:], ids: [])
        addNode(id: 1, type: 2, data: ["img": "img1", "text": "number 1"], ids: [])
        
        
        
        addNode(id: 2, type: 1, data: ["text": "selector", "app": "true"], ids: [11])
        add_ids(node: nodes[0], ids: [2])
        
        
        
        for i in 5...10 {
            addNode(id: i, type: 8, data: ["text": "", "switch": "false"], ids: [])
            change_rule(id: i, key: "button_touch", value: ["1", "UpdateDataAndRefresh"])
            change_rule(id: i, key: "UpdateDataAndRefresh", value: ["1", "UpdateData", "refresh"])
            change_rule(id: i, key: "UpdateData", value: ["0", "\(i)", "switch", "flip"])
            change_rule(id: i, key: "refresh", value: ["0"])
            add_ids(node: nodes[2], ids: [i])
        }
        
        addNode(id: 11, type: 8, data: ["text": "", "switch": "false", "button_title": "Start", "button_background":"green-rect", "button_background1":"green-full", "button_title1":"End", "textcolor":"green"], ids: [])
        
        
        
        change_rule(id: 11, key: "button_touch", value: ["1", "UpdateDataAndRefresh", "if"])
        change_rule(id: 11, key: "UpdateDataAndRefresh", value: ["1", "UpdateData", "refresh"])
        
        
        change_rule(id: 11, key: "push_stack", value: ["0", "send", "1", "2", "3"])
        change_rule(id: 11, key: "UpdateData", value: ["0", "11", "switch", "flip"])
        change_rule(id: 11, key: "refresh", value: ["0"])
        
//        addNode(id: 2, type: 2, data: ["img": "img2", "text": "number 2"], ids: [4])
//        addNode(id: 3, type: 1, data: ["img": "img1", "text": "number 3"], ids: [5,6])
//        addNode(id: 4, type: 1, data: ["img": "img2", "text": "number 4"], ids: [])
//        addNode(id: 5, type: 1, data: ["img": "img1", "text": "number 5"], ids: [])
//        addNode(id: 6, type: 1, data: ["img": "img2", "text": "number 6"], ids: [7,8])
//        addNode(id: 7, type: 1, data: ["img": "img1", "text": "number 7"], ids: [])
//        addNode(id: 8, type: 1, data: ["img": "img2", "text": "number 8"], ids: [])
//        
//        addNode(id: 10, type: 5, data: ["img": "ceil2", "text": "Cell 2"], ids: [])
//        addNode(id: 11, type: 6, data: [:], ids: [])
//        
//        
//        // update bot view
//        addNode(id: 12, type: 2, data: ["img": "img1", "text": "UPDATE BOT"], ids: [13, 14, 15, 16, 17, 18, 19])
//
//        addNode(id: 12, type: 1, data: ["img": "img1", "text": "UPDATE BOT"], ids: [])
//        
//        addNode(id: 13, type: 1, data: ["img": "img1", "text": "ID"], ids: [])
//        addNode(id: 14, type: 6, data: [:], ids: [])
//        
//        addNode(id: 15, type: 1, data: ["img": "img1", "text": "Key"], ids: [])
//        addNode(id: 16, type: 6, data: [:], ids: [])
//        
//        addNode(id: 17, type: 1, data: ["img": "img1", "text": "Value"], ids: [])
//        addNode(id: 18, type: 6, data: [:], ids: [])
//        
//        addNode(id: 19, type: 7, data: [:], ids: [])
        
        
        
        
        
        
        // adding function
//        addNode(id: 100, type: 1, data: ["text": "add a block"], ids: [101, 102])
//        let high_tech_node = query(id: 100)!
//        high_tech_node.rules["new_block"] = [0]
        
        
//        addNode(id: 101, type: 4, data: ["img": "add_button", "text": "Select Your Block : )"], ids: [])
//        addNode(id: 102, type: 5, data: ["img": "ceil2", "text": "Cell 2"], ids: [])
        
//        addNode(id: 999, type: 999, data: [:], ids: [])
//        let k = query(id: 999)!
//        k.rules["Back"] = "true"
//        
//        addNode(id: 1000, type: 999, data: [:], ids: [])
//        let a = query(id: 1000)!
//        a.rules["add"] = "true"
//        a.rules["refresh"] = "true"
//        a.rules["woaixuexi"] = "woaixuexi"
//        a.rules["save"] = [14, 16, 18]
//        a.rules["change_rule"] = "save"
//        a.rules["change_data"] = "save"
//        a.rules["read"] = "woaixuexi"
    }
    
    
    func addNode(id: Int, type: Int, data: [String:String], ids: [Int]) {
        let node = Node(id: id, type: type, data: data)
        
        var forward_ids = node.rules["Expand"] as! [String]
        for id in ids{
            forward_ids.append(String(id))
        }
        node.rules["Expand"] = forward_ids

        nodes.append(node)
        
    }
    
    func add_ids(node: Node, ids: [Int]){
        var forward_ids = node.rules["Expand"] as! [String]
        for id in ids{
            forward_ids.append(String(id))
        }
        node.rules["Expand"] = forward_ids
    }
//    func addNodeAuto()-> Int{
//        let id = 100000 + nodes.count
//        
//        let node = Node.init(id: id)
//        node.type = 2
//        node.data["img"] = "img1"
//        node.data["text"] = "img2"
//        nodes.append(node)
//        
//        add_node_to_(targe_id: 0, node_id: id)
//        
//        return id
//    }
//
//    func add_node_to_(targe_id: Int, node_id: Int){
//        
//        print("===========")
//        print(targe_id, node_id)
//        print("===========")
//        var forward_ids = query(id: targe_id)!.rules["Expand"] as! [Int]
//        forward_ids.append(node_id)
//        query(id: targe_id)!.rules["Expand"] = forward_ids
//        //node.rules["Expand"] = forward_ids
//        
//    }
    
    func query(id: Int)->Node?{
        for node in nodes {
            if node.id == id {
                return node
            }
        }
        return nil
    }
    
//    func run_(query: Query)-> [Node]{
//        let actions: [String] = query.actions
//        if actions.count > 0{
//            for action in actions {
//                
//                if action == "new_block"{
//                    addNodeAuto()
//                }
//                
//                return []
//            }
//        } else {
//            let ids = query.ids
//            return query_by_(ids: ids)
//        }
//        return []
//    }
    
    func query_by_(ids: [Int]) -> [Node] {
        var results: [Node] = []
        
        for id in ids {
            if let result = query(id: id){
                results.append(result)
            }
        }
        return results
    }
    
    
    var core_data:[Node] = []
    var meta_data:[String:String] = [:]
    
    // THE ONLY FAKED REST API ENDPOINT
    func run_query_with_(id: Int, rule rule_name: String)->(core_data:[Node], meta_data:[String:String]){
        if let node = query(id: id){
            let rules = node.rules
//            display query name
            print("id")
            print(id)
            print("rules")
            print(rules)
            if rules[rule_name] != nil {
                print(rule_name)
                let results = run_init(rule: (rule_name, rules[rule_name]) as (String, Any) , node: node)
                (rule: (rule_name, rules[rule_name]) as (String, Any), of_node: node)
                if meta_data["system"] != "0" {
                    return results
                }
            }
//            if rules.count > 0{
//                for rule in rules{
//                    // run only first rule now
//                    let results = run_(rule: rule, of_node: node)
//                    return results
//                }
//            }
        }
        return ([], ["system":"404"])
    }
    

    
    
    func run_init(rule:(String, Any), node: Node)->([Node], [String:String]){
        core_data = []
        meta_data = [:]
        meta_data["direction"] = "stuck"
        print("run_init")
        print(rule)
        run(rule, node)
        return (core_data, meta_data)
    }
    
    func run(_ rule:(String,Any), _ node: Node){
        
        let key = rule.0
        let mapper = Int((rule.1 as! [String])[0])!
        var vals = (rule.1 as! [String])
        vals.remove(at: 0)
        
        print("run rule")
        print(key, mapper, vals)
        
        switch mapper {
        case 0:
            take_action(key, vals, node)
        case 1:
            run_in_order(key, vals, node)
        default:
            print("404 Mapper Not Found")
        }
        
    }
    
    func woaixuexi(){
        nodes = []
        addNode(id: 0, type: 0, data: [:], ids: [])
    }
    
    func change_data(id: Int, key: String, value: String) {
        if let node = query(id: id){
            node.data[key] = value
        }
    }
    
    func change_rule(id: Int, key: String, value: [String]){
        if let node = query(id: id){
            node.rules[key] = value
        }
    }
    
    // MARK:= Mapper Functions
    
    
    //
    
    func take_action(_ key: String, _ vals: [String], _ node: Node){
        print("take_action === ")
        print(key)
        switch key {
        case "Expand":
            let ids = vals
            for id in ids{
                if let result = query(id: Int(id)!){
                    core_data.append(result)
                    meta_data["direction"] = "forward"
                    meta_data["core_data"] = "replace"
                }
            }
        case "UpdateData":
            if (vals.count < 3){
                meta_data["error"] = "UpdateDate failed - not enough vals"
                print("UpdateDate failed - not enough vals")
            } else {
                change_data(id: Int(vals[0])!, key: vals[1], value: vals[2])
                
                
                print("Print All Data")
                for node in nodes {
                    print(node.data)
                }
            }
        case "refresh":
            meta_data["direction"] = "fuck"
        default:
            print("404 Action Not Found")
        }
        
        
//        if key == "Back" {
//            meta_data["direction"] = "backward"
//            meta_data["core_data"] = "replace"
//        }
//
//        if key == "Expand" {
//            let
//            let ids = node.rules["Expand"] as! [Int]
//            for id in ids{
//                if let result = query(id: id){
//                    core_data.append(result)
//                    meta_data["direction"] = "forward"
//                    meta_data["core_data"] = "replace"
//                }
//            }
//        }
//        
//        if key == "back_expand" {
//            let ids = node.rules["Expand"] as! [Int]
//            for id in ids{
//                if let result = query(id: id){
//                    core_data.append(result)
//                    meta_data["core_data"] = "replace"
//                    meta_data["direction"] = "backed"
//                }
//            }
//
//            
//        }
//        
//        if key == "display" {
//            let ids = node.rules["Expand"] as! [Int]
//            for id in ids{
//                if let result = query(id: id){
//                    core_data.append(result)
//                    meta_data["core_data"] = "replace"
//                    meta_data["direction"] = "no"
//                }
//            }
//        }
//        
//        if key == "add" {
//            addNodeAuto()
//        }
//        
//        if key == "refresh"{
//            meta_data["core_data"] = "stuck"
//            meta_data["direction"] = "fuck"
//        }
//        
//        if key == "woaixuexi" && rule.1 as! String == "woaixuexi" {
//            woaixuexi()
//            meta_data["core_data"] = "replace"
//            meta_data["direction"] = "fuck"
//        }
//        
//        if key == "save" {
//            let ids = rule.1 as! [Int]
//            for id in ids{
//                if let node = query(id: id){
//                    print(node)
//                    print("Node Finished Yet")
//                }
//            }
//        }
    }
    
    func run_in_order(_ key: String, _ vals: [String], _ node: Node){
        for val in vals {
            let rules = node.rules
            if rules[val] != nil{
                print("** && **")
                print("   ++   ")
                print(val, rules[val])
                run((val, rules[val]), node)
            } else {
                meta_data["error"] = "run in order failed with rule \(key) and subruls \(vals)"
            }
            
        }
    }
    
}
