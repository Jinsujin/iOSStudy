//: [Previous](@previous)

import Foundation


//----- 의존성 ----//
class AClass {
    var number: Int = 1
}

// AClass의 변수를 내부에 가짐으로서
// BClass 와 AClass 는 의존 관계가 생기게 된다.
class BClass {
    var aClass = AClass()
}

let b = BClass()
print(b.aClass)





//---- 주입 ----//
// 내부가 아닌, 외부에서 객체를 생성해 넣어주는 것

class CClass {
    var number: Int
    
    init(withNumber number: Int) {
        self.number = number
    }
    
    func setNumber(number: Int) {
        self.number = number
    }
}

// 외부에서 객체를 생성해 넣음
let c = CClass(withNumber: Int(1))
print(c.number)

// 외부에서 객체를 생성해 넣음
c.setNumber(number: Int(2))
print(c.number)






//---- 의존성 + 주입 => 아직은 완전한 DI가 아님 ----//
// 의존성 분리가 필요.
class DClass {
    var aClass: AClass
    
    init(withVariable variable: AClass) {
        self.aClass = variable
    }
}

let d = DClass(withVariable: AClass())
d.aClass.number





//---- 의존성 분리 ----//
// DI는 의존성을 분리시켜 사용.
// protocol(Interface) 을 사용하여 의존성을 분리시킨다.
    // == 의존관계 역전(Inversion Of Control): 의존의 방향이 역전되었다.(의존의 전이를 끊었다)
// 제어의 주체가 protocol에 있다. => protocol의 코드를 분석해서 흐름을 파악할 수 있다.
protocol DIInterface: AnyObject {
    var number: Int { get set }
}

// DIInterface 에 의존관계가 있는 클래스
class MyClass: DIInterface {
    var number = 10
}
 
// MyClass 와 의존관계가 있는 클래스
class EClass {
    // 내부변수로 MyClass 를 사용
    var variable: DIInterface
    
    // 외부에서 MyClass 객체를 받아 초기화
    init(withExternalVariable variable: DIInterface) {
        self.variable = variable
    }
}

let e = EClass(withExternalVariable: MyClass())
print(e.variable.number) // MyClass.number 10







//---- DI-- Constructor Injection (생성자 주입) ----//
protocol Eatable {
    var calorie: Int { get }
}

struct Pizza: Eatable {
    var calorie: Int {
        return 300
    }
}

class FoodTruck {
    let food: Eatable
    
    init(food: Eatable) {
        self.food = food
    }
}

let foodTruck = FoodTruck(food: Pizza())
print(foodTruck.food.calorie) // 300





//---- DI-- Property Injection (저장속성에 주입) ----//
class Market {
    var food: Eatable?
}

let market = Market()
market.food = Pizza()
print(market.food?.calorie)






//---- DI-- Method Injection (함수를 통한 주입) ----//
class HomeMade {
    var food: Eatable?
    
    func setupFood(_ food: Eatable) {
        self.food = food
    }
}

let homeMade = HomeMade()
homeMade.setupFood(Pizza())
print(homeMade.food?.calorie)







//---- POP-- Example ----//
protocol Walkable {
    var isBareFoot: Bool { get set } // 맨발여부
    var speed: Double { get set }
    func walk(name: String)
}

// Base가 되는 요구사항을 미리 정의
// 중복되는 코드들을 extension 으로 관리할 수 있다.
extension Walkable {
    func walk(name: String) {
        if isBareFoot {
            print("\(name) 은 맨발로 \(speed)속도로 걷는다")
            return
        }
        print("\(name) 은 신발을 신은채 \(speed)속도로 걷는다")
    }
}

protocol Flyable {
    func fly()
}

extension Flyable {
    func fly() {
        print("날다")
    }
}

protocol Runable {
    func run()
}

extension Runable {
    func run() {
        print("뛰다")
    }
}

struct Person: Walkable, Runable {
    var isBareFoot: Bool
    var speed: Double
}

struct Animal: Walkable {
    var isBareFoot: Bool
    var speed: Double
}

struct Bird: Flyable, Runable, Walkable {
    var isBareFoot: Bool
    var speed: Double
}

let jin = Person(isBareFoot: false, speed: 1.0)
jin.walk(name: "JIN")

let dog = Animal(isBareFoot: true, speed: 2.0)
dog.walk(name: "Jindol")

let twit = Bird(isBareFoot: true, speed: 0.3)
twit.fly()
twit.run()
twit.walk(name: "참새")




//: [Next](@next)
