//
//  Car.swift
//  ListNavDemo
//
//  Created by jsj on 2020/07/05.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

/**
 
 Identifiable: 각 인스턴스를 ListView에서 식별가능케 함
 */
struct Car: Codable, Identifiable {
    var id: String
    var name: String
    
    var description: String
    var isHybrid: Bool
    
    var imageName: String
    
}
