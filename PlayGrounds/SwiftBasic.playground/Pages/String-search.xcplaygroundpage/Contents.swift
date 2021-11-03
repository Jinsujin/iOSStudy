//: [Previous](@previous)

import Foundation

/**
 문자의 검색과 제거
 
 */

var userEmail = " my-email@example.com "
// 공백 문자 제거 - 앞뒤로만 다듬을수 있다.
var trimmedString = userEmail.trimmingCharacters(in: [" "])
print(trimmedString)

// .whitespaces 는 공백문자 " " 를 뜻함. 자주쓰는 타입은 정의되어 있어 사용할 수 있다.
trimmedString = userEmail.trimmingCharacters(in: .whitespaces)
print(trimmedString)


// 앞뒤의 특정 문자 제거. 중간은 제거할수 없다
var someString = "?Swift!"
var removeString = someString.trimmingCharacters(in: ["?", "!"])
print(removeString)

/**
 중간에 있는 문자 제거
 해당 특수문자를 기준으로 잘라서 배열로 만든다음, 다시 문자열로 변환
 */
// 중간의 공백문자 제거
// " " 를 기준으로 잘라서 요소화 시킨다
var name = "S t e v e"
var removed = name.components(separatedBy: " ").joined() // ["", "S", "t", "e", "v", "e", ""]
print(removed)

// 중간에 포함된 특수문자 제거
var phoneNum = "010-1234-1234"
var removedPhoneNum = phoneNum.components(separatedBy: "-").joined() // ["010", "1234", "1234"]
print(removedPhoneNum)


// 여러개의 특수문자를 한꺼번에 제거
var numString = "1+2-3*4/5"
var removedString = numString.components(separatedBy: ["+", "-", "*", "/"]).joined()
print(removedString)


//
var str = "Hello Swift"
var arr = str.split(separator: " ") // 서브스트링으로 반환
print(arr)
print(arr.joined())

// split 은 Substring 배열로 반환
str.split(separator: " ")

// split 은 클로저를 파라미터로 받는다
str.split { $0 == " " }
str.split { chr in
    return chr == " " || chr == "."
}


// 문자셋을 이용하기


/**
 문자열 검색
 */
// + 특수문자 인덱스 범위 알아내기
name = "hello+world"
if let range = name.rangeOfCharacter(from: .symbols) {
    print(name[range])
}





//: [Next](@next)
