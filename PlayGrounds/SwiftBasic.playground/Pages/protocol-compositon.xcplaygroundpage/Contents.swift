//: [Previous](@previous)

import Foundation
/**
 Composition
 부품이 될 클래스에 인터페이스를 채택하여 만들어서 이를 조립하며 각기 다른 객체들을 만들어 나가는 것.
 */

// MARK:- 플레이어
struct PlayerState {
    var name: String = "NoName"
    var str: Int = 0
    var def: Int = 0
    var hp: Int = 0
}

class GamePlayer {
    private let weapon: WeaponProtocol
    private let armor: EquipmentProtocol
    private var state: PlayerState
    
    init(name: String, weapon: WeaponProtocol, armor: EquipmentProtocol) {
        self.weapon = weapon
        self.armor = armor
        self.state = PlayerState(name: name, hp: 0)
    }
    
    private func wearEquipments() {
        self.weapon.equip(state: &state)
        self.armor.equip(state: &state)
        print("[SYSTEM:: 장비를 장착했습니다. str:\(state.str), def:\(state.def)]")
    }
    
    func battle() {
        wearEquipments()
        self.weapon.attack(self.state)
    }
    
    // 휴식
    func rest() {
        let prevHP = self.state.hp
        self.state.hp += 10
        print("💤 휴식중 입니다... HP가 \(prevHP)->\(self.state.hp) 로 회복되었습니다.")
    }
}

// MARK:- 부품이 될 장비의 프로토콜
protocol EquipmentProtocol {
    func equip(state: inout PlayerState)
}

protocol WeaponProtocol: EquipmentProtocol {
    func attack(_ state: PlayerState)
}

extension WeaponProtocol {
    func attack(_ state: PlayerState) {
        print("⚔️ \(state.name)의 공격! \(state.str) 대미지를 주었습니다. ⚔️")
    }
}

protocol ArmorProtocol: EquipmentProtocol {
    func defense(_ state: PlayerState)
}

// MARK:- 프로토콜을 채택한 여러가지 장비 클래스
class LongSword: WeaponProtocol {
    func equip(state: inout PlayerState) {
        state.str += 10
    }
}

class Wand: WeaponProtocol {
    func equip(state: inout PlayerState) {
        state.str += 1
    }
    func attack(_ state: PlayerState) {
        print("🔥 \(state.name)의 마법 공격! \(state.str * 16) 대미지를 주었습니다. 🔥")
    }
}

class NoWeapon: WeaponProtocol {
    func equip(state: inout PlayerState) {}
}


class ChainMail: ArmorProtocol {
    func equip(state: inout PlayerState) {
        state.def += 20
    }
    func defense(_ state: PlayerState) {
        print("\(state.name)이(가) ChainMail 로 방어했습니다!")
    }
}

class LeatherJacket: ArmorProtocol {
    func equip(state: inout PlayerState) {
        state.def += 3
    }
    func defense(_ state: PlayerState) {
        print("\(state.name)이(가) LeatherJacket 로 방어했습니다!")
    }
}


// MARK:- 조립하기
// 장비 - 무기들
let wand = Wand()
let longSword = LongSword()
let hand = NoWeapon()

// 장비 - 갑옷들
let leatherJacket = LeatherJacket()
let chainMail = ChainMail()

let swordMan = GamePlayer(name: "검사", weapon: longSword, armor: chainMail)
let magician = GamePlayer(name: "마법사", weapon: wand, armor: leatherJacket)

swordMan.battle()
swordMan.rest()
magician.battle()





//: [Next](@next)
