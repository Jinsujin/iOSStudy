//: [Previous](@previous)

import Foundation
/**
    defer
 - 할일을 미룬다.
 - 코드의 실행을 스코프가 종료되는 시점으로 연기.
 - 현재 코드블럭을 나가기 전에 꼭 실행해야 하는 코드를 작성해
    블록을 빠져 나가기전에 마무리 해야 하는 작업을 할 수 있도록 도와준다. (정리하는 개념)
 - for 문 사용시, 다음 주기로 넘어가기전에 실행.
 */


func deferTest() {
    defer {
        print("defer 1")
    }
    defer {
        print("defer 2")
    }
    defer {
        print("defer 3")
    }
    print("Hello Swift!")
}

//deferTest()
// 실행결과 - 코드블럭을 빠져나가기전에 역순으로 실행
//Hello Swift!
//defer 3
//defer 2
//defer 1


func nestedDeferTest() {
    defer {
        print("defer 1") //7
    }
    do {
        defer {
            print("do defer 2") //2
        }
        print("do end") //1
    }
    
    for i in 0..<2 {
        defer{
            print("forin defer 3") //4
        }
        print("forin End") //3
    }
    
    defer {
        print("defer 4") //6
    }
    
    print("Hello Swift!") //5
}

//nestedDeferTest()


// MARK:- defer 가 호출되지 않는 경우
// 코드블럭을 벗어나기 직전에 호출되지만, defer를 선언했다고 해서 반드시 호출되는 것은 아니다.
// defer 이 반드시 호출되어야 예약이 되어 나중에 실행할 수 있다.

// 1. throw 를 이용해서 오류를 던질 경우
// 중간에 throw 가 발생해 함수가 종료될 경우, 아래 선언된 defer 까지 도달하지 못해 함수가 종료되어도 defer 가 호출되지 않는다
// defer 도 하나의 실행 코드이기 때문.
func thorwError(_ isError: Bool) throws -> Void {
    defer {
        print("defer 1")
    }
    
    if isError {
        enum TestError: Error {
            case error
        }
        throw TestError.error
    }
    
    defer {
        print("defer 2")
    }
    
    print("End function")
}

//print("-----Error True-----")
//try? thorwError(true)
//defer 1

//print("-----Error False-----")
//try? thorwError(false)
//End function
//defer 2
//defer 1




// 2. guard 문을 사용해 중간에 함수를 종료하는 경우
func guardDefer(_ str: String?) {
    defer { print("defer 1") }
    guard let str = str else { return }
    defer { print("defer 2") }
    print("End function")
}

//print("------string nil-------")
//guardDefer(nil)
// defer1

//print("------string not nil-------")
//guardDefer("Swift!")
//End function
//defer 2
//defer 1


// 리턴값이 Never(비반환함수) 인경우
// 에러가 발생하면서 함수를 반환하지 않고 실행을 종료. => defer 호출되지 않음
func neverDefer() -> Never {
    defer { print("defer 1") }
    defer { print("defer 2") }
    defer { print("defer 3") }
    abort()
}

//neverDefer()



//: [Next](@next)
