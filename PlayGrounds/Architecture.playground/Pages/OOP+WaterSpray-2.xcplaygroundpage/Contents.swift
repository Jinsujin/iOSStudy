//: [Previous](@previous)

import Foundation

/**
 객체간 상호작용하기
 이전 코드에서는 분무기와 화분사이에 어떠한 의존 관계도 없다.
 누군가가 이 두 클래스 간에서 중재를 하고 있는 상황.
 
 OOP 는 개체간 상호작용이 필요하다.
 */


class WaterSpray {
    private(set) var capacity: Int
    private(set) var 남아있는물의양Ml: Int = 0
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    
    // addWater 라는 이름이 setter 보다 의미가 명확.
    func addWater(amount ml: Int) {
        if (self.남아있는물의양Ml + ml) > self.capacity {
            return
        }
        self.남아있는물의양Ml += ml
    }
    
    func fillUp() {
        self.남아있는물의양Ml = capacity
    }
    
    func spray() {
        if (self.남아있는물의양Ml - 5) < 0 {
            return
        }
       self.남아있는물의양Ml -= 5
    }
}

// 화분
class FlowerPot {
    // 한번 죽은 꽃은 살아날 수 없으므로 setter는 없다.
    private var alive = true
    private(set) var 매일필요한물의양Ml: Int
    
    init(_ 매일필요한물의양: Int) {
        self.매일필요한물의양Ml = 매일필요한물의양
    }
    
    func isAlive() -> Bool {
        return alive
    }
    
    private var 하루에받은물의양 = 0
//    func addWater(amount ml: Int) {
//        self.하루에받은물의양 += ml
//    }
    
    // 개체간 상호작용 할수 있도록 수정
    func addWater(spray: WaterSpray) {
        var water: Int = spray.남아있는물의양Ml
        spray.spray()
        water -= spray.남아있는물의양Ml
        하루에받은물의양 += water
    }
    
    
    // 하루가 지났을때 호출할 함수
    // 개체 스스로 하루가 지나면, 죽었는지 살았는지 판정
    func liveAnotherDay() {
        if (하루에받은물의양 < 매일필요한물의양Ml) {
            alive = false
        }
        하루에받은물의양 = 0
    }
}


// 방법1. 분무기를 화분에 대고 뿌린다.
// WaterSpray ---> FlowerPot 의존
// WaterSpray
//func spray(to pot: FlowerPot) {
//    let amountToSpray: Int = 남아있는물의양Ml < 5 ? 남아있는물의양Ml : 5
//    pot.addWater(amount: amountToSpray)
//    self.남아있는물의양Ml -= amountToSpray
//}

// 호출
// => 캡슐화, 추상화
//for i in 0..<2 {
//    waterSpray.spray(to: pot)
//}



// 방법2. 분무기를 줄테니 스스로 뿌리세요
// FlowerPot ---> WaterSpray 의존
// FlowerPot
//func addWater(spray: WaterSpray) {
//    var water: Int = spray.남아있는물의양Ml
//    spray.spray()
//    water -= spray.남아있는물의양Ml
//    하루에받은물의양 += water
//}
// 호출
// => 캡슐화, 추상화
//for i in 0..<2 {
//    pot.addWater(waterSpray)
//}


/**
 두 방법중 좋은것은?
 1. 분무기를 화분에 대고 뿌린다. - 사람에게 익숙한 생각

 2.  분무기를 줄테니 스스로 뿌리세요 - 뭔가 어색..=>  하지만, 조금더 개체지향적에 가깝다.
 개체 스스로 책임을 질 수 있다.
 어디로 부터 물을 받을수 있는지 특정 가능.
 
 실세계의 object 는 수동적인 존재로 누군가 조작해줘야 한다.
 하지만, OO 세계의 object 는 자기 주관을 가진 주체.
 
 */



let waterSpray = WaterSpray(200)
waterSpray.fillUp()

let pot = FlowerPot(10)

for _ in 0..<2 {
    pot.addWater(spray: waterSpray) // 간결해진 코드
}
pot.liveAnotherDay()
print("화분이 살았나? ", pot.isAlive())





//: [Next](@next)
