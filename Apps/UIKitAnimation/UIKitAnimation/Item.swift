//
//  Item.swift
//  UIKitAnimation
//
//  Created by jsj on 2021/03/15.
//

import UIKit

enum Item: String, CaseIterable {
    case cheese = "cheese"
    case cherry = "cherry"
    case choco = "choco"
    case chocogreen = "chocogreen"
    case chocovanila = "chocovanila"
    case mint = "mint"
    case oreo = "oreo"
    case shooting = "shooting"
}

extension UIImage {
    convenience init(item: Item){
        self.init(named: item.rawValue)!
    }
}

extension UIImageView {
    convenience init(item: Item) {
        self.init(image: .init(item: item))
    }
}
