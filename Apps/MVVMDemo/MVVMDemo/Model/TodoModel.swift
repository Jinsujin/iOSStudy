//
//  TodoModel.swift
//  MVVMDemo
//
//  Created by jsj on 2020/07/01.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation


struct Todo: Decodable {
    let id: Int
    let title: String
    let isDone: Bool
}
