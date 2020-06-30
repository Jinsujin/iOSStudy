//
//  TodoViewModel.swift
//  MVVMDemo
//
//  Created by jsj on 2020/06/30.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation
import UIKit

struct TodoViewModel {
    let title: String
    let detailTextString: String
    let accessoryType: UITableViewCell.AccessoryType
    
    // Dependency Injection
    init(todo: Todo){
        self.title = todo.title
        
        if todo.isDone {
            detailTextString = "Complete😃"
            accessoryType = .detailDisclosureButton
        } else {
            detailTextString = "Not Complete"
            accessoryType = .none
        }
        
    }    
}


