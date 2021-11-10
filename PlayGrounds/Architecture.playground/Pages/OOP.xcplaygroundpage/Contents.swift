//: [Previous](@previous)

import Foundation

class Animal {
    let name: String
    let leg: Int
    init(name: String, leg: Int = 4) {
        self.name = name
        self.leg = leg
    }
    func shout() {
        print("외쳐!")
    }
}


class Dog: Animal {
    let nose: Float
    
    init(name: String, nose: Float = 2.0) {
        self.nose = nose
        super.init(name: name)
    }
    
    func bite() {
        print("문다")
    }
    
    override func shout() {
        print("멍멍")
    }
}


class Cat: Animal {
    init(name: String) {
        super.init(name: name)
    }
    override func shout() {
        print("야옹")
    }
}


let 진돌이 = Dog(name: "진돌")
let 나비 = Cat(name: "나비")

let animals: [Animal] = [진돌이, 나비]
animals.forEach({ $0.shout() })


//
class Notification {
    let massage: String = "알림 메시지"
}


/*
// STEP1.
func orderCancel() {
    // 주문 취소 로직 실행 - 이 메서드의 주요 기능
    let pushEnabled = true
    
    // 요구사항 추가
    if (pushEnabled) {
        // 이메일을 보낸다
    } else {
        // 문자를 보낸다
    }
}
*/

/*
// STEP2.
// if 문에서 사용하는 곳에서 공통된 성질 추출 => 인터페이스로 정의
protocol Notifier {
    func notify(noti: Notification)
}

class EmailNotifier: Notifier {
    func notify(noti: Notification) {
        print("이메일 발송")
    }
}

class SMSNotifier: Notifier {
    func notify(noti: Notification) {
        print("문자 발송")
    }
}

func orderCancel() {
    // 주문 취소 로직 실행 - 이 메서드의 주요 기능
    let pushEnabled = true
    
    let notifier = getNotifier(pushEnabled)
    notifier.notify(noti: Notification())
}


func getNotifier(_ isEnable: Bool) -> Notifier {
    if(isEnable) {
        return EmailNotifier()
    } else {
        return SMSNotifier()
    }
}

 */
 
/*
// STEP3.
// 사용할 대상 접근도 추상화
// getNotifier : 실제 구현 객체를 생성 => NotifierFactory 로 추상화
protocol Notifier {
    func notify(noti: Notification)
}

class EmailNotifier: Notifier {
    func notify(noti: Notification) {
        print("이메일 발송")
    }
}

class SMSNotifier: Notifier {
    func notify(noti: Notification) {
        print("문자 발송")
    }
}
func cancel() {
    // 주문 취소 로직 실행 - 이 메서드의 주요 기능
    let pushEnabled = true
    
//    let notifier = getNotifier(pushEnabled)
//    notifier.notify(noti: Notification())
    
//    Notifier notifier = NotifierFactory.instance().getNotifier(pushEnabled)
//    notifier.notify(noti: Notification())

}


protocol NotifierFactory {
    func getNotifier(_ isEnable: Bool) -> Notifier
//    static func instance() -> NotifierFactory
}

extension NotifierFactory {
//    static func instance() -> NotifierFactory {
//        return DefaultNotifierFactory()
//    }
}

class DefaultNotifierFactory: NotifierFactory {
    func getNotifier(_ isEnable: Bool) -> Notifier {
        if(isEnable) {
            return EmailNotifier()
        } else {
            return SMSNotifier()
        }
    }
}

 */


open class A {
    public func add(a: Int, b: Int) {
        print(a + b)
    }
}

A().add(a: 1, b: 2)


//: [Next](@next)
