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



//: [Next](@next)
