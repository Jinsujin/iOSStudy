//
//  Model.swift
//  MultipleCellTableApp
//
//  Created by jsj on 2020/07/21.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation

enum CellModel {
    case collectionView(models: [CollectionTableCellModel], rows: Int)
    case list(models: [ListCellModel])
}

struct ListCellModel {
    let title: String
    
}

struct CollectionTableCellModel {
    let title: String
    let imageName: String
}
