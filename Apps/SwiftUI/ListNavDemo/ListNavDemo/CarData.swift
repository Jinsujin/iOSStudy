//
//  CarData.swift
//  ListNavDemo
//
//  Created by jsj on 2020/07/05.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit
import SwiftUI

/**
    JSON 파일을 읽어서 Car 객체로 변환하여 반환
 
 
 */

var carData: [Car] = loadJson("carData.json")

func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("\(filename) not found")
    }
    
    do {
        data = try Data(contentsOf: fileURL)
    } catch {
        fatalError("Could not load \(filename): \(error)")
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    }catch{
        fatalError("Unable to parse \(filename): \(error)")
    }
    
}


