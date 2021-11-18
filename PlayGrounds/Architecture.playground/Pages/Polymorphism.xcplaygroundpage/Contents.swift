//: [Previous](@previous)

import Foundation


/**
 다형성: 어떤 개체가 다양한 형태로 변할 수 있는 능력
 
 */

// 개체의 실제 형에 따라 다른 행동을 한다

class Animal {
    func shout() {
        print("shout")
    }
    
    final func walk() {
        print("걷는다")
    }
}

class Bird: Animal {
    override func shout() {
        print("짹짹")
    }
}


class Dog: Animal {
    override func shout() {
        print("멍멍")
    }
}

class Lion: Animal {
    override func shout() {
        print("크앙")
        super.shout() // 부모의 메서드를 호출
    }
}

let lion = Lion()
lion.shout()


let bird = Bird()
bird.shout()

let dog = Dog()
dog.shout()

// 부모형으로 자식 개체를 참조
let animal: Animal = Bird()
animal.shout() // "짹쨱"

// 자식형으로 부모 개체 참조(컴파일 오류)
//let animalDog: Dog = Animal()


//: [Next](@next)
