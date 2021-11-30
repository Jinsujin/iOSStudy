//: [Previous](@previous)

import Foundation


/*
 프로토콜 활용
 struct, class 를 하나의 배열에 담기
 
 참고사이트
 http://minsone.github.io/mac/ios/swift-protocols-summary
 */

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}


class Car: FullyNamed {
    var name: String
    var prefix: String?
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

let jin = Person(fullName: "jinsu")
let car = Car(name: "BBip")

var namedArr: [FullyNamed] = [jin, car]
namedArr.forEach{ print($0.fullName) }




/**
 값 타입에서 인스턴스를 변경해야 할때
 */
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()



/**
 이니셜라이저
 */

protocol myProtocol {
    init(num: Int)
}

class myClass: myProtocol {
    required init(num: Int) {
        // todo something...
    }
}

//서브클래스가 슈퍼클래스로부터 지정 이니셜라이저와 준수하는 이니셜라이저 요구사항의 구현을 오버라이드할때
//required override 를 지정메서드에 붙여줘야 한다.
protocol SomeProtocol {
    init()
}

class SomeSuperClass {
    init() {
        print("SomeSuperClass init()")
    }
}
 
class SomeSubClass: SomeSuperClass, SomeProtocol {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        print("SomeSubClass init()")
    }
}

let someSubClass = SomeSubClass()
//SomeSubClass init()
//SomeSuperClass init()


/**
 Protocol Composition
 여러개의 프로토콜을 조합할 수 있다
 */

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Dog: Named, Aged {
    var name: String
    var age: Int
}

//Named & Aged 를 상속하는 타입만 인자로 받을 수 있다.
func wishHappyBirthday(celebrator: Named & Aged) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}

let birthdayDog = Dog(name: "jindol", age: 3)
wishHappyBirthday(celebrator: birthdayDog)


/**
 프로토콜 준수를 위한 검사(Checking for Protocol Conformance)
 * `is`: 인스턴스가 프로토콜을 준수하면 true, 아니면 alse를 반환.
 * `as?`: 연산자 다운캐스팅 버전.
        프로토콜의 타입의 옵셔널 값을 반환. (인스턴스가 프로토콜과 준수하지 않으면 nil 값을 가짐)
 * `as`:  연산자 다운캐스팅 버전.
        프로토콜 타입을 강제로 다운캐스팅.
        다운캐스팅이 성공하지 않으면 런타임 에러가 발생.
 */
@objc protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

// protocol 을 지키지 않음
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 10.0),
    Animal(legs: 4)
]

for object in objects {
    if let obj = object as? HasArea {
        print("Area is \(obj.area)")
    } else {
        print("Something that doesn't have an area")
    }
}


//: [Next](@next)
