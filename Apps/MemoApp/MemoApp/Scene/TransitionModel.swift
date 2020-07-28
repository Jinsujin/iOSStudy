//
//  TransitionModel.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation

/**
    전환방식을 표현하는 열거형
 
 */

enum TransitionStyle {
    case root
    case push
    case modal
    
}

/**
    에러방식
 
 */
enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
