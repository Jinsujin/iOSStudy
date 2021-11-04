//: [Previous](@previous)

import UIKit

/**
 사용자 정의 연산자
 */


var i = 0
i += 1
//i++ // swift 에 없는 연산기호 구현하려면?

// ++ 기호를 postfix 연산자로 사용한다고 선언.
postfix operator ++

extension Int {
    // 타입메서드로 구현
    static postfix func ++(num: inout Int) {
        num += 1
    }
}


i++




//: [Next](@next)
