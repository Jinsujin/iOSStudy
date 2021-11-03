//: [Previous](@previous)

import Foundation

/**
 문자열 비교
 
 */

// 유니코드 비교
"swift" < "Swift" // false, 첫글자(유니코드) 의 순서를 비교
"swift" <= "Swift" // false, 소문자가 유니코드 상에서 더 뒤에 위치함
"Swift" <= "swift" // true

// 대소문자 무시하고 비교
"swift".lowercased() == "Swift".lowercased()


/**
 대소문자 무시하고 비교 - caseInsensitiveCompare 메서드 사용

 NSComparisonResult 는 열거형 타입으로 정의되어 있다.
 Bool 타입에 비해 더 자세한 비교 결과값을 알 수 있다.
 - .orderedSame
 - .orderedAscending // 오름차순
 - .orderedDescending // 내림차순
 */
var a = "swift"
var b = "Swift"
let compareResult = a.caseInsensitiveCompare(b) // NSComparisonResult
//compareResult == ComparisonResult.orderedSame
switch compareResult {
case .orderedAscending:
    print("오름차순")
case .orderedDescending:
    print("내림차순")
case .orderedSame:
    print("동일한 차순")
}


/**
 문자열 비교 메서드 compare
 
 String.CompareOptions
 .caseInsensitive  // 대소문자 무시
 .regularExpression // 정규식 검증
 
 */
var name = "Hello, Swift"

// StringProtocol:
// Option:
// Range: 비교할 범위
name.compare("hello", options: [.caseInsensitive, .anchored]) == .orderedDescending // 내림차순


/**
 OptionSet 프로토콜
 이 프로토콜을 채택하면, 메서드를 사용할때 여러개의 옵션을 배열 형식으로 전달 가능
 
 EX)
 struct CompareOptions: OptionSet
 */
//struct A {
//    struct B {
//
//    }
//}
//A.B



/**
 문자열 포함 여부 확인하기
 
 */
let string = "Hello, world!"

// 전체 문자열에서 포함 여부
string.contains("Hello")
string.lowercased().contains("hello")
string.contains("world")


//접두어, 접미어 포함여부
string.hasPrefix("Hello")
string.hasPrefix("world")
string.lowercased().hasPrefix("world")

string.hasSuffix("!")
string.hasSuffix("world!")


// 접두어, 접미어 반환 - 앞에서 혹은 뒤에서 몇글자 뽑아내기
string.prefix(2)// 앞에서부터 2글자
string.suffix(3) // 뒤에서부터 3글자

// 공통 접두어 반환
string.commonPrefix(with: "Hello, swift")
string.commonPrefix(with: "hello", options: [.caseInsensitive])

// 앞에서 3글자를 빼고
string.dropFirst(3)
string.dropLast(3)


//: [Next](@next)
