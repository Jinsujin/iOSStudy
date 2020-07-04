//
//  CarStore.swift
//  ListNavDemo
//
//  Created by jsj on 2020/07/05.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI
import Combine

/**
    List 뷰는 최신데이터를 유지 => 사용자 인터페이스는 published property 를 포함해야 함
 
 */

class CarStore: ObservableObject {
    // 게시자
    @Published var cars: [Car]
    
    init(cars: [Car] = []) {
        self.cars = cars
    }
    
    
}
