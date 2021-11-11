//: [Previous](@previous)

import Foundation

/**
 3 에서의 문제점:
 1. 머리와 몸통을 따로 만들어야 한다. => 미리 규격을 정해둔다 ( 예. S, M, L)
 2. 분무기에서 곧바로 분무하지 못함.
 */


// 규격화
enum SprayHeadSpeed {
    case SLOW, MEDIUM, FAST
}

enum BottleSize {
    case SMALL, MEDIEM, LARGE
}


class SprayHead {
    let sprayAmout: Int
    init(sprayAmout: Int) {
        self.sprayAmout = sprayAmout
    }
    
    func sprayFrom(source body: SprayBottle) {
        body.reducerWater(sprayAmout)
    }
}

class SprayBottle {
    private(set) var capacity: Int
    private(set) var 남아있는물의양Ml: Int = 0
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    func addWater(amount ml: Int) {
        if (self.남아있는물의양Ml + ml) > self.capacity {
            return
        }
        self.남아있는물의양Ml += ml
    }

    func fillUp() {
        self.남아있는물의양Ml = capacity
    }

    func reducerWater(_ ml: Int) {
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
    
    // 규격화를 통한 초기화
    init(speed: SprayHeadSpeed, size: BottleSize) {
        switch speed {
        case .SLOW:
            self.head = SprayHead(sprayAmout: 1)
        case .MEDIUM:
            self.head = SprayHead(sprayAmout: 5)
        case .FAST:
            self.head = SprayHead(sprayAmout: 50)
        }
        
        switch size {
        case .SMALL:
            self.body = SprayBottle(10)
        case .MEDIEM:
            self.body = SprayBottle(50)
        case .LARGE:
            self.body = SprayBottle(150)
        }
    }
    
    func addWater(amount ml: Int) {
        self.body.addWater(amount: ml)
    }
    
    func fillUp() {
        self.body.fillUp()
    }
    
    func getRemainingWater() -> Int {
        return body.남아있는물의양Ml
    }
    
    func spray() {
        head.sprayFrom(source: body)
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
    /*
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
 */
    
    // 변경 후
    func addWater(spray: WaterSpray) {
        var water = spray.getRemainingWater()
        spray.spray()
        water -= spray.getRemainingWater()
        하루에받은물의양 += water
    }
    
    func liveAnotherDay() {
        if (하루에받은물의양 < 매일필요한물의양Ml) {
            alive = false
        }
        하루에받은물의양 = 0
    }
}


// 편리해진 부품 조립
let spray_smallButFast = WaterSpray(speed: .FAST, size: .SMALL)
let spray_largeButSlow = WaterSpray(speed: .SLOW, size: .LARGE)


// 화분에 물뿌리기
spray_smallButFast.body.fillUp()
let pot = FlowerPot(10)

for _ in 0..<2 {
    pot.addWater(spray: spray_smallButFast)
}
pot.liveAnotherDay()
print("살아있나? ", pot.isAlive())

//: [Next](@next)
