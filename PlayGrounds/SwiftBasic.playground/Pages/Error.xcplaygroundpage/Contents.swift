//: [Previous](@previous)

import Foundation


/**
 에러 처리 Error Handling
 
 - 데이터 처리를 요청했을때, 에러가 발생하면 앱이 꺼질수 있는 상황이 발생한다(크래시)
 - 발생할 수 있는 에러를 미리 처리하여 강제종료 되지 않도록 에러 처리를 할 수 있다.
 
 예) 서버에서 데이터를 가져와서 보여주는 로직에서, 데이터를 가져오지 못했을때 사용자에게 어떻게 이 문제를 알려주는게 좋은가?

 
 // input void, output void
 () throws -> ()
 
 // input Int output void
 (Int) throws -> ()
 
 */


// 1. Error protocol을 채택한 Error 정의
enum HeightError: Error {
    case minHeight
    case maxHeight
}


// 2. 에러가 발생할 수 있는 함수 정의
/// throws 키워드를 붙여, 에러를 던질 수 있음을 나타냄
func checkHeight(height: Int) throws -> Bool {
    
    if height > 190 {
        throw HeightError.maxHeight
    } else if height < 130 {
        throw HeightError.minHeight
    } else {
        return true
    }
}

// 3.
// 에러를 던지는 함수를 실행할때는 try 를 붙여준다.
// try 는 docatch 에서 do{} 안에서 사용
do { // 정상적인 경우의 처리
    let result = try checkHeight(height: 200)
    print(result)
} catch {
    // checkHeight 함수에서 에러를 던졌을경우, 여기서 처리한다
    // error 상수를 제공한다
//    print(error.localizedDescription)
    
    // 타입 캐스팅을 통해 에러를 받아 분기처리
    if let error = error as? HeightError {
        switch error {
        case .maxHeight:
            print("👾 키가 너무 큽니다! 👾")
        case .minHeight:
            print("👾 키가 너무 작습니다! 👾")
        }
    }
}



// 함수 내에서 에러를 직접 처리하지 못하는경우, 에러를 다시 던질 수 있다
func handleError() throws {
    try checkHeight(height: 140)
}


func throwingFunc() throws {
    throw HeightError.maxHeight
}


// rethrowing 함수로 에러 다시 던지기
// 에러를 던질수 있는 함수를 파라미터로 사용할때는 rethrows 키워드를 사용.
func someFuction1(callback: () throws -> Void) rethrows {
    try callback()
}


do {
    try someFuction1(callback: throwingFunc)
} catch {
    print(error)
}


// MARK:- 생성자에 throw 적용
enum CarError: Error {
    case noname
}

class Car {
    var name: String
    
    init(name: String) throws {
        if name == "" {
            throw CarError.noname
        } else {
            self.name = name
            print("자동차 생성 성공!")
        }
    }
}

do {
    let _ = try Car(name: "")
} catch CarError.noname {
    print("이름이 없어 자동차 생성에 실패했습니다.")
}


//: [Next](@next)
