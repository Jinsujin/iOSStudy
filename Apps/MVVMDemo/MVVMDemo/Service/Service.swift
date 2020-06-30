//
//  Service.swift
//  MVVMDemo
//
//  Created by jsj on 2020/06/30.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation


/**
 
 Singleton Pattern - class constant
 */
class Service {
    
//    fileprivate let jsonData = """
//    [
//        {
//            "id": "0",
//            "title": "Clean my room",
//            "isDone": "false"
//        },
//        {
//            "id": "1",
//            "title": "Shopping width family",
//            "isDone": "true"
//        }
//    ]
//    """
    
    static let shared = Service()
    
    init(){ print("Service init") }
    
    // todos, error
    func fetchTodos(_ completion: @escaping (([Todo]?, Error?) -> Void)) {
        print("fetchTodos")
        
        let path = "/Users/jsj/dev/iOS/swift/Apps/MVVMDemo/MVVMDemo/todolist.json"
        
//        let contents = try? String(contentsOfFile: path).data(using: .utf8)
        
        
        
        
//        let todos = try JSONDecoder().decode(Todo.self, from: jsonData)
        //todolist.json
        if let url = Bundle.main.url(forResource: "todolist", withExtension: "json") {
//        if let url = Bundle.main.path(forResource: "todolist", ofType: "json") {
            do {
                print("url == ", url)
                
                
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode([Todo].self, from: data)
                
//                let data = try NSData(contentsOfFile: url, options: NSData.ReadingOptions.mappedIfSafe)
//                let jsonData = try JSONDecoder().decode([Todo].self, from: data as Data)
                
                completion(jsonData, nil)
            } catch {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
        
    }
}

