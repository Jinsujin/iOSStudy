//: [Previous](@previous)

import Foundation

/**
 정규식
 
 ?: 있을수도 있고, 없을수도 있다.
 .* // 점 부터 별표까지 어떤 문자라도 쓸수 있다.
 */

// 올바른 전화번호인지 판별하기
let number = "010-1234-1234"

// [0-9] 숫자 0~9까지
// {3} 3자리
// # 정규식을 쓸때 앞뒤로 샵을 붙여준다.
var telephoneNumRegex = #"[0-9]{3}\-[0-9]{4}\-[0-9]{4}"#

// range - 문자열의 범위를 정규식으로 알아내기
if let _ = number.range(of: telephoneNumRegex, options: [.regularExpression]) {
    print("올바른 전화번호 입니다.")
}





//: [Next](@next)
