//: [Previous](@previous)

import Foundation

/**
 출처
 https://medium.com/@armanbkar/solid-design-principles-in-swift-de24e76356d4
 
 SOLID 는 소프트웨어 설계를 보다 이해하기 쉽고, 유연하며, 유지관리를 쉽게 할 수 있도록 하기 위한 5가지 설계 정신이다.
 구조를 설계할때 따라야 하는 설계 패턴과 아키텍쳐의 필요성을 이해하고,
 소프트웨어 설계를 보다 이해하기 쉽고 유연하게 할 수 있도록 도와준다.
 
 
 */


/**
 The Single Responsibility Principle
 단일 책임 원칙
 */

protocol Openable {
    mutating func open()
}

protocol Closeable{
    mutating func close()
}

// SimpleDoor 구조체는 캡슐화되어 있어서, state를 바꿀려면 메서드를 통해 바꿀수 있다.
struct SimpleDoor: Openable, Closeable {
    private enum State {
        case open, closed
    }
    
    private var state: State = .closed
    mutating func open() {
        self.state = .open
    }
    
    mutating func close() {
        state = .closed
    }
}

// DoorOpener class 는 문을 열 책임이 있는지 안에 무엇이 있는지, 어떻게 문을 닫아야 하는지 전혀 알지 못한다.
final class DoorOpener {
    private var door: Openable
    
    init(door: Openable) {
        self.door = door
    }
    
    func execute() {
        door.open()
    }
}

// DoorCloser class 는 문을 닫아야 하며, 그 안에 무엇이 있는지 어떻게 문을 열어야 하는지 전혀 알지 못한다.
final class DoorCloser {
    private var door: Closeable
    
    init(door: Closeable) {
        self.door = door
    }
    func execute() {
        door.close()
    }
}

let door = SimpleDoor()

// DoorOpener class 만 문을 열 수 있다.
let doorOpener = DoorOpener(door: door)
doorOpener.execute()

// 문을 닫을때 알람을 켜는것과 같이
// 다른 작업을 수행해야 하는 경우에는 DoorOpener class 를 변경할 필요가 없다.
let doorCloser = DoorCloser(door: door)
doorCloser.execute()


/**
 The Open-Closed Principle
 개방 폐쇄 원칙
 확장에는 열려있고, 변경에는 닫혀있다.
 */
protocol Shooting {
    func shoot() -> String
}

// LaserBean class 는 레이저 빔을 쏠 수 있다.
final class LaserBeam: Shooting {
    func shoot() -> String {
        return "💥Biiiiiip!"
    }
}

final class WeaponsComposite {
    let weapons: [Shooting]
    init(weapons: [Shooting]) {
        self.weapons = weapons
    }
    
    func shoot() -> [String] {
        return weapons.map { $0.shoot() }
    }
}

let laser = LaserBeam()
var weapons = WeaponsComposite(weapons: [laser])
weapons.shoot()

// 여기있는 RocketLauncher class 는 로켓을 쏠 수 있다.
// WeaponsComposite class에 로켓 런쳐를 서포트하기위해 기존 클래스에서 아무것도 변경할 필요가 없다.
final class RocketLauncher: Shooting {
    func shoot() -> String {
        return "Whooosh!☄️"
    }
}

let rocket = RocketLauncher()
weapons = WeaponsComposite(weapons: [laser, rocket])
weapons.shoot()


/**
 리스코프 치환 원칙
 Liskov Substitution Principle
 
 RequestError 는 NSError 의 서브클래스이며, 추가 기능을 제공하지만 원래 기능은 건드리지 않는다.
 */

/**
 The Interface Segregation Principle
 클라이언트는 사용하지 않는 interface에 의존하도록 강요되어서는 안된다.
 */


/**
 Dependency Inversion Principle
 상위 수준의 모듈은 하위 수준 모듈에 의존해서는 안된다.
 둘 다 추상화애 의존해야 한다. 추상화는 세부사항에 의존해서는 안된다.
 즉, 당신의 실체는 구체적이 아니라 추상화에 의존해야 한다.
 */
protocol TimeTraveling {
    func timeInTime(time: TimeInterval) -> String
}

final class DeLorean: TimeTraveling {
    func timeInTime(time: TimeInterval) -> String {
        return "time: \(time)s"
    }
}

//EmmetBrown은 DeLorean 이라는 구체적 클래스 DeLorean 이 아닌, TimeTraveling 디바이스로 주어진다.
final class EmmettBrown {
    private let timeMachine: TimeTraveling
    init(timeMachine: TimeTraveling) {
        self.timeMachine = timeMachine
    }
    
    func travelInTime(time: TimeInterval) -> String {
        return timeMachine.timeInTime(time: time)
    }
}

let timeMachine = DeLorean()
let mastermind = EmmettBrown(timeMachine: timeMachine)
mastermind.travelInTime(time: -3600 * 8760)



//: [Next](@next)
