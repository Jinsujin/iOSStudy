//: [Previous](@previous)

import Foundation

var arr1 = ["apple", "orange"]
var arr2 = arr1

// String 은 값타입이므로 깊은 복사가 일어난다.
print("arr1", arr1)
print("arr2", arr2)



// 참조타입은 얕은복사가 일어나 같은 주소값을 가진다
class Address {
    var address: String
    
    init(_ string: String) {
        self.address = string
    }
}

var a1 = Address("Busan")
var a2 = a1

// reference type 의 깊은 복사
// copy() 메서드로 깊은 복사 하기
//: [Next](@next)
