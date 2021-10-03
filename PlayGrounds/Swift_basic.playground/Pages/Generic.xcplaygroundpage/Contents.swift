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
 - 제네릭에서 타입을 제약할 수 있다.
 - 타입 매개 변수 이름뒤에 프로토콜 제약 조건 또는 단일 클래스를 배치할 수 있다.
 1) 프로토콜 제약인 경우: <T: Equatable>
 2) 클래스 제약인 경우: <T: SomeClass>
 
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



class Person {}
class Student: Person {}

// Person 을 부모로 가진 클래스만 이 함수를 사용할 수 있다.(구조체, 열거형은 사용하지 못한다)
func personClassOnly<T: Person>(array: [T]) {
    print("personClassOnly")
}

personClassOnly(array: [Student(), Student()])



// MARK:- Protocol
/**
 - associatedtype Type(연관 타입) 로 선언해야 한다
 RemoteControl<T> 가 아닌, associatedtype 로 선언해야 한다
 
 */

//typealias MyType = Int

protocol RemoteControl {
    associatedtype T // class<T> 와 같은 선언
    func changeChannel(to: T)
    func alert() -> T?
}


struct TV: RemoteControl {
    typealias T = Int // 프로토콜을 채택했을때 명시적으로 어떤 타입으로 쓸건지 언급. 생략가능
    
    func changeChannel(to: Int) {
        print("TV 의 채널 변경:", to)
    }
    
    func alert() -> Int? {
        return 1
    }
}


// 연관 형식에 타입제약 추가하기
protocol RemoteControl2 {
    associatedtype Element: Equatable
    func alert() -> Element?
}

//: [Next](@next)
