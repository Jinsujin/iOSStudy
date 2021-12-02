//
//  Stack.swift
//  Unit
//
//  Created by jsj on 2021/12/02.
//

import Foundation

/**
 LIFO (나중에 들어간것이 먼저 나온다)
 요구사항
 - push: 요소를 넣는다
 - pop: 가장 나중에 들어간 요소를 반환하고, 스택에서 삭제
 - peek: 가장 나중에 들어간 요소를 반환
 - size: 스택 크기 반환
 
 */
class Stack {
    private var array: [Int]
    init() {
        array = []
    }
    
    func push(_ element: Int) {
        array.append(element)
    }
    
    @discardableResult
    func pop() -> Int? {
        if array.count == 0 {
            fatalError("pop:Empty array")
        }
        return array.popLast()
    }
    
    func peek() -> Int {
        if array.count == 0 {
            fatalError("peek:Empty array")
        }
        return array[array.count - 1]
    }
    
    var size: Int {
        array.count
    }
}
