//: [Previous](@previous)

import Foundation


/**
 Sequence Protocol
 - 순차적 작업이 필요할떄 사용
 - 요소들의 목록으로 각각의 원소들을 하나씩 순회하는 것. (값을 반복할 수 있는 타입)
 - 채택하면, forEach, map, filter 등 다양한 함수 사용이 가능해짐
 - Array 가 Sequence protocol을 채택하고 있기에 for in 구문을 사용할 수 있는것.

 특징
 1. 한번만 iterate 할수 있다
 2. 무한하거나 유한하다
 
 구현방법
 makeIterator() 메서드를 구현해야 하며, swift runtime은 for in 루프를 초기화할때 이 메서드를 호출한다.
 makeIterator() 메서드의 반환값 Iterator 가 IteratorProtocol 을 채택하므로, 결국 Iterator protocol 을 준수해야 한다
 */


/**
Iterator Protocol
 요소를 추가하거나 반복할떄 사용
 
 구현방법:
 next() 메서드를 구현해야 한다.
 
 next()
 시퀸스의 다음 요소를 반환.
 nil 이 반환되면 swift runtime 은 for in루프를 이용한 반복기에서 더이상 순회할 요소가 없음을 알게된다. (=배열의 마지막 위치)
 
 */


// MARK:- 예제
struct CountDown: Sequence {
    var value: Int
    
    struct CountDownIterator: IteratorProtocol {
        var value: Int
        mutating func next() -> Int? {
            if value < 0 { return nil }
            defer{value -= 1}
            return value
        }
    }
    
    func makeIterator() -> CountDownIterator {
        return CountDownIterator(value: self.value)
    }
}

// 5,4,3,2,1,0
//for i in CountDown(value: 5) {
//    print(i)
//}


struct SimpleCountDown: Sequence, IteratorProtocol {
    var value: Int
    mutating func next() -> Int? {
        if value < 0 { return nil }
        value -= 1
        return value// + 1
    }
}

// 5,4,3,2,1,0
for i in SimpleCountDown(value: 5) { print(i) }


//: [Next](@next)
