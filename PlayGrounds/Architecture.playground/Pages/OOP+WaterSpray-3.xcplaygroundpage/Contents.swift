//: [Previous](@previous)

import Foundation

/**
 분무기를 머리와 몸통으로 분리하기.
 머리와 몸통의 집합이 분무기 => 각 개체는 분리되어 사용가능하다.
 
 */

class SprayHead {
    let sprayAmout: Int
    init(sprayAmout: Int) {
        self.sprayAmout = sprayAmout
    }
    
    func sprayFrom(source body: SprayBottle) {
        body.reduceWater(sprayAmout)
    }
}

class SprayBottle {
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
    
    func reduceWater(_ ml: Int) {
        남아있는물의양Ml -= 남아있는물의양Ml < ml ? 남아있는물의양Ml : ml
    }
}

class WaterSpray {
    private(set) var head: SprayHead
    private(set) var body: SprayBottle
    
    init(head: SprayHead, body: SprayBottle) {
        self.head = head
        self.body = body
    }
}

// 화분
class FlowerPot {
    private var alive = true
    private(set) var 매일필요한물의양Ml: Int
    
    init(_ 매일필요한물의양: Int) {
        self.매일필요한물의양Ml = 매일필요한물의양
    }
    
    func isAlive() -> Bool {
        return alive
    }
    
    private var 하루에받은물의양 = 0
    
    // 문제: 분무기에서 바로 분무를 하지못한다. 복잡한 분무과정.
    func addWater(spray: WaterSpray) {
        // 분무동작은 head에서 하지만, 실제 물이 줄어드는 것은 body
        // spray() 메서드는 몸통을 알아야 한다
        let head = spray.head
        let body = spray.body
        var water = body.남아있는물의양Ml
        head.sprayFrom(source: body)
        water -= body.남아있는물의양Ml
        하루에받은물의양 += water
    }
    
    func liveAnotherDay() {
        if (하루에받은물의양 < 매일필요한물의양Ml) {
            alive = false
        }
        하루에받은물의양 = 0
    }
}

// 개체를 조립해서 분무기 생성.
let head = SprayHead(sprayAmout: 5)
let body = SprayBottle(100)
body.fillUp()
let waterSpray = WaterSpray(head: head, body: body)

let pot = FlowerPot(10)

for _ in 0..<2 {
    pot.addWater(spray: waterSpray)
}
pot.liveAnotherDay()
print("화분이 살았나? ", pot.isAlive())




// 장점: 다양한 스펙을 가진 머리와 몸통을 섞어 조합할 수 있다.
let headSlow = SprayHead(sprayAmout: 1)
let bodyXL = SprayBottle(300)


//: [Next](@next)
