//: [Previous](@previous)

import Foundation

struct Coordinates<T> {
    var x: T
    var y: T
}

// 확장에 제네릭 사용 가능.
extension Coordinates {
    func getPlace() -> (T, T) {
        return (x, y)
    }
}

let place = Coordinates(x: 0, y: 0)
print(place.getPlace())


// Int Type에만 extension 을 추가하고 싶을 경우
extension Coordinates where T == Int {
    func getIntArray() -> [T] {
        return [x, y]
    }
}

print(place.getIntArray())

let placeDouble = Coordinates(x: 4.5, y: 2.0)
//placeDouble.getIntArray() // Error


/**
 타입 제약 Type Constraint
 Equatable Protocol: == 값 비교 가능
 */
// Equatable 을 채택한 타입만 이 함수를 사용할 수 있다.
// 값을 비교 (==) 하려면, 타입제약이 필요하기 때문
func findIndex<T: Equatable>(item: T, array: [T]) -> Int? {
    for (idx, value) in array.enumerated() {
        if item == value {
            return idx
        }
    }
    return nil
}


findIndex(item: 5, array: [5,6,7]) // 0




//: [Next](@next)
