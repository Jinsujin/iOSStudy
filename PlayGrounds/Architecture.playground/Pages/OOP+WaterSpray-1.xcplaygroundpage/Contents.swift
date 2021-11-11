//: [Previous](@previous)

import Foundation

/*
 분무기 만들기
 
 명세서
 - 화분에 꽃이 피어져 있다.
 - 꽃은 매일 일정량의 물을 뿌려주면 평생 살 수 있다.
 - 물을 뿌릴때 사용하는 도구는 분무기 이다.
 - 하루라도 필요한 물을 공급받지 못하면 꽃은 죽는다.
 - 한번 죽은 꽃은 살아날 수 없다.
 
 
 다이어그램으로 나타내기
 - 상수는 변하는 값이 아니므로, 멤버변수로 보지 않는다. => 다이어그램에 나타내지 않는다.
 
 */

class WaterSpray {
    private(set) var capacity: Int
    private(set) var 남아있는물의양Ml: Int = 0
//    var 남아있는물의양Ml: Int {
//        get {
//            return _남아있는물의양Ml
//        }
//        set {
//            _남아있는물의양Ml = newValue
//        }
//    }
    
    // 읽기는 internal, 쓰기는 private
    internal private(set) var name = "이름"
    
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
    
// 하루에 한번뿌리는것을 가정. -> 하루에 여러변 뿌릴수 있도록 하려면 수정필요.
//    func addWater(물의양: Int) {
//        if (물의양 < 매일필요한물의양Ml) {
//            alive = false
//        }
//    }
    
    private var 하루에받은물의양 = 0
    func addWater(amount ml: Int) {
        self.하루에받은물의양 += ml
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


let waterSpray = WaterSpray(200)
waterSpray.fillUp()

let pot = FlowerPot(10)

for i in 0..<2 {
    var water: Int = waterSpray.남아있는물의양Ml
    waterSpray.spray()
    water -= waterSpray.남아있는물의양Ml
    pot.addWater(amount: water)
}
pot.liveAnotherDay()
print("화분이 살았나? ", pot.isAlive())



//: [Next](@next)
