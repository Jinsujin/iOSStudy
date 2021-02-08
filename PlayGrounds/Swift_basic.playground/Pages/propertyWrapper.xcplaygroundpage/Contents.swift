//: [Previous](@previous)

import Cocoa

/**
 프로퍼티 래퍼
 
 @propertyWrapper  지시자로 선언.
 클래스나 구조체 안에 구현됨.
 모든 프로퍼티 래퍼는 값을 변경하거나 유효성을 검사하는 getter, setter 코드가 포함된 wrappedValue 프로퍼티를 가져야 함

 */


struct Address {
//    var city: String
    
    // city 는 대문자로만 저장 가능하다
    private var cityName: String = ""
    
    // 연산 프로퍼티를 구조체에 추가
    var city: String {
        get { cityName }
        set { cityName = newValue.uppercased() }
    }
}

var address = Address()

address.city = "Korea"
print(address.city)


/**
 연산 프로퍼티 대신, 프로퍼티 래퍼로 구현하기
 
 초기값을 문자열을 대문자로 변환하고, wrappedValue에 할당
 */

@propertyWrapper
struct FixCase {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.uppercased() }
    }
    
    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

struct Contact {
    @FixCase var name: String
    @FixCase var city: String
    @FixCase var country: String
}

print(Contact(name: "Jin", city: "Seoul", country: "Korea"))

//: [Next](@next)
