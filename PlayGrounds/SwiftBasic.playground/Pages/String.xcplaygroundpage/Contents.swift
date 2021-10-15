//: [Previous](@previous)

import Foundation


// 문자열을 여러줄 입력하려면, """ 쌍따옴표 3개를 이어서 입력
let description = """
hello, swift!\
줄바꿈은 없애려면 이렇게 백슬래쉬를 붙인다.
"쌍따옴표도 입력 가능하다"
"""
print(description)



/**===============================
  특수문자 - Escape sequences
 \0 : null 문자
\\ : 백슬래시
 \u{유니코드값} : 1~8 자리의 16진수
 ===============================**/


// Raw String - 확장 구분자
// # 기호로 앞뒤를 감싸면, 내부의 문자열을 그대로 인식하게 된다.
// 특수문자를 편하게 입력하게 하기위해 사용
var name = #"jin"#
var hello = #"hello \#nswift"#
print(hello)

let st = #"Hello \#(name)"#
print(st)


/**===============================
문자열 보간법 (String Interpolation)

 문자열 보간법을 사용할때, 출력형태를 프로토콜을 통해 직접 구현할 수 있다
protocol CustomStringConvertible {
    var description { get }
 }
 
 \() 문자열 보간법은  CustomStringConvertible.description 속성을 읽는것과 같다
 또는.appendInterpolation 메서드를 호출하는 것과 같다.
 ===============================**/

struct People {
    var name: String
    var age: Int
}

let jin = People(name: "jin", age: 11)
print(jin)
//People(name: "jin", age: 11)
//=> 이름: jin, 나이: 11

/// swift 4 이하
// 각 타입에 구현
//extension People: CustomStringConvertible {
//    var description: String {
//        return "이름: \(name), 나이: \(age)"
//    }
//}

// swift5 이상
// String 에 구현
extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: People) {
        appendInterpolation("이름: \(value.name), 나이: \(value.age)")
    }
    
    // 커스텀
    mutating func appendInterpolation(_ value: Int, style: NumberFormatter.Style) {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        //...
    }
    
//    mutating func appendInterpolation(_ value: Animal) {
//        appendInterpolation("이름: \(value.name), 나이: \(value.age)")
//    }
}


/**===============================
  숫자를 문자열로 변환
 
 ===============================**/
// 반올림

// 1. Format Specifiers
let pi = 3.1415926
var str: String = ""
str = String(3.1415926) // 문자열 생성자 사용
print(str)

//String(format: <#T##String#>, arguments: <#T##[CVarArg]#>)

// f: 실수 / d: 정수 / @: 문자열
// .3: 소수점 아래 3자리
// %: 숫자지정
print(String(format: "%.3f", pi)) // 3.142
print(String(format: "%.2f", pi)) // 3.14
print(String(format: "%.1f", pi)) // 3.1

String(format: "%d", 10)
String(format: "%2d", 10) //2자리표현
String(format: "%02d", 10) //2자리표현, 비어있다면 0

String(format: "%07.3f", pi) // 7자리표현, 0과 . 포함, 소수점 아래 3자리

String(format: "Hello, %@", jin.name)


print(String(format: "%1$.2f, %2$.2f", 4.53, 2.6553))


// 1$ : 첫번째 파라미터, 2$: 두번쨰 파라미터
var firstName = "jin"
var lastName = "su"
var korean = "사용자의 이름은 %2$@ %1$@ 입니다."
var english = "The user name is %1$@ %2$@."

print(String(format: korean, firstName, lastName))
print(String(format: english, firstName, lastName))



/**===============================
  Number formatter 사용하기
 
 ===============================**/

// 소수점 버리기
let numberFormatter = NumberFormatter()
numberFormatter.roundingMode = .floor // 버림
numberFormatter.maximumSignificantDigits = 3 // 최대 표현할 자리수

let value1 = 3.14567
var valueFormatted = numberFormatter.string(for: value1)
print(valueFormatted!)
//3.14

numberFormatter.roundingMode = .floor
numberFormatter.minimumSignificantDigits = 4 // 최소 표현할 자리수

let value2 = 3.1
valueFormatted = numberFormatter.string(for: value2)
print(valueFormatted)
// 3.100


// 세자리수 마다 콤마 넣기
numberFormatter.numberStyle = .decimal
let price = 10000000
let result = numberFormatter.string(for: price)
print(result)
// 10,000,000



/**===============================
  Substring
 - 메모리 공간을 공유한다는 개념.
 greeting 의 메모리를 같이 공유해서 사용한다.
 beginning 이라는 변수는 원본 메모리 공간을 공유하고 있는것. 새로 메모리공간을 만드는게 아님
 수정이 일어나기 전까지 메모리 공간 공유.
 

 ===============================**/
var greeting = "Hello, world!"
let index: String.Index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning: String.SubSequence = greeting[..<index] //Hello  "," 에 해당하는 인덱스앞까지 문자열을 뽑는다.


// 앞에서 5글자를 뽑아낸다
let word: String.SubSequence = greeting.prefix(5)

// 원본을 바꾸면, substring 문자열들은 새로운 문자열 공간을 만들어서 저장한다.
greeting = "Wow"


// 새로운 메모리 공간을 만들어서 저장. 이때는 공유하지 않음
let newString: String = String(word)

//: [Next](@next)
