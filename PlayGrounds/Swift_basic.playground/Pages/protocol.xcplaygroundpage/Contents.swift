//: [Previous](@previous)

import Foundation

// --------------- 커피 만들기 ------------------------ //
//struct Coffee {
//    let shots: Int
//    let hasMilk: Bool?
//}
//
//// MARK:- Protocol
//// protocol: 자격증. 그 자격증을 가진 행위자
//// pro, 일반 maker
//protocol CoffeeMaker {
//    func makeCoffee(shots: Int) -> Coffee
//}
//
//protocol CoffeeProMaker {
//    func makeCoffee(shots: Int) -> Coffee
//    func fillCoffeeBeans(beans: Int)
//    func clean()
//}
//
//
//class CoffeeMachine: CoffeeMaker, CoffeeProMaker {
//    private static let BEANS_GRAM_PER_SHOT: Int = 7
//    private var coffeeBeans: Int = 0
//
//    private init(beans: Int) {
//        self.coffeeBeans = beans
//    }
//
//    static func makeMachine(beans: Int) -> CoffeeMachine {
//        return CoffeeMachine(beans: beans)
//    }
//
//    func fillCoffeeBeans(beans: Int) {
//        if (beans < 0) { return }
//        coffeeBeans = beans
//    }
//
//    private func grindBeans(_ shots: Int) {
//        print("grinding beans for \(shots)")
//        let needBeans = shots * CoffeeMachine.BEANS_GRAM_PER_SHOT
//        if (coffeeBeans < needBeans) {
//            print("Not enough coffee beans")
//            return
//        }
//        coffeeBeans -= needBeans
//    }
//
//    private func extract(_ shots: Int) -> Coffee {
//        print("Extract \(shots) shots...☕️")
//        return Coffee(shots: shots, hasMilk: nil)
//    }
//
//    func makeCoffee(shots: Int) -> Coffee {
//        grindBeans(shots)
//        return extract(shots)
//    }
//
//    func clean() {
//        print("Clean the machine...")
//    }
//}
//
//
//// MARK:- User class
//class MakerUser {
//    let machine: CoffeeMaker
//    init(machine: CoffeeMaker) {
//        self.machine = machine
//    }
//
//    func makeCoffee() {
//        let coffee = machine.makeCoffee(shots: 1)
//        print("Maker made: \(coffee)")
//    }
//}
//
//class BaristaUser {
//    let machine: CoffeeProMaker
//    init(machine: CoffeeProMaker) {
//        self.machine = machine
//    }
//
//    func makeCoffee() {
//        let coffee = machine.makeCoffee(shots: 1)
//        print("Barista made: \(coffee)")
//    }
//}
//
//
//let maker = CoffeeMachine.makeMachine(beans: 100) //CoffeeMachine
//let amateur = MakerUser(machine: maker)
//let pro = BaristaUser(machine: maker)
//
//pro.makeCoffee()
//amateur.makeCoffee()



// --------------- 빵만들기 ------------------------ //
struct Bread {
    let dough: Int // 반죽개수
    let egg: Int?
}

// MARK:- Protocol. 빵을 만들 수 있는 자격증
protocol BakeryCertification {
    func makeBread(dough: Int) -> Bread
}

protocol MasterBakeryCertification: BakeryCertification {
    func fillWheat(wheats: Int)
    func clean()
}


class MagicOven: MasterBakeryCertification {
    private static let wheatsPerDough: Int = 12 // 반죽 하나에 들어가는 밀가루 양
    private var wheats = 0
    
    private init(wheats: Int) {
        self.wheats = wheats
    }
    
    static func makeOven(wheats: Int) -> MagicOven {
        print("---✨ 마법의 오븐을 생성합니다 ✨---")
        return MagicOven(wheats: wheats)
    }
    
    func makeBread(dough: Int) -> Bread {
//        if !knead(dough) { return }
        knead(dough)
        return bake(dough)
    }

    func fillWheat(wheats: Int) {
        print("밀가루 채우는 중: \(wheats)gram...")
        self.wheats = wheats
    }
    
    func clean() {
        print("오븐 청소중....🧹")
    }
    
    @discardableResult
    private func knead(_ dough: Int) -> Bool {
        let needWheats = dough * Self.wheatsPerDough
        if (self.wheats < needWheats) {
            return false
        }
        self.wheats -= needWheats
        print("밀가루 반죽중...")
        return true
    }
    
    private func bake(_ dough: Int) -> Bread {
        print("굽는중...도우\(dough)개로 만들어요.")
        return Bread(dough: dough, egg: nil)
    }
}



// MARK:- User. 행위자
class AmateurUser {
    let oven: BakeryCertification
    init(oven: BakeryCertification) {
        self.oven = oven
    }
    func makeBread(dough: Int){
        print("🧑🏼‍🍳 AmateurUser 가 빵을 굽기 시작했습니다!")
        let _ = self.oven.makeBread(dough: dough)
        print("띵! AmateurUser가 구운 빵이 완성되었어요 🍞")
    }
}

class ProUser {
    let oven: MasterBakeryCertification
    init(oven: MasterBakeryCertification) {
        self.oven = oven
    }
    func makeBread(dough: Int){
        print("🌟🧑🏼‍🍳 ProUser 가 빵을 굽기 시작했습니다!")
        let _ = self.oven.makeBread(dough: dough)
        print("띵! ProUser가 구운 빵이 완성되었어요 🍞🌟")
    }
}


// MARK:- 사용 예
let oven = MagicOven.makeOven(wheats: 100)
let amateurUser = AmateurUser(oven: oven)
let proUser = ProUser(oven: oven)

amateurUser.makeBread(dough: 2)
proUser.makeBread(dough: 4)
proUser.oven.fillWheat(wheats: 20)





//: [Next](@next)
