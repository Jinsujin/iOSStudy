import UIKit

/**
    불투명 반환 타입
 
 함수가 결과를 반환한다면, 함수 선언부에 반환타입을 명시해야 한다.
 
 */

func doubleFunc(value: Int) -> Int {
    return value * 2
    
}


/**
  - 불투명 반환 타입을 사용하면, 지정된 프로토콜을 따르는 모든 타입이 반환될 수 있다.
  - Equatable 프로토콜을 따르는 모든 타입을 반환
 
 Equatable: Swift 가 제공하는 표준 프로토콜.
 이 프로토콜을 따르기 위해서는, 값들이 서로 동일한지 비교할 수 있어야 하지만,  불투명 반환타입은 모든 프로토콜에 사용될 수 있다.
 */
func doubleFunc1(value: Int) -> some Equatable {
    value * 2
}


func doubleFunc2(value: String) -> some Equatable {
    value + value
}

print(doubleFunc1(value: 3))
print(doubleFunc2(value: "나"))
