import UIKit

/**
 단일 표현식에서 암묵적 반환
 함수가 단일 표현식을 가지고 있다면, return 구문을 생략 가능
 */

func printIntroduceWord(name: String, age: Int) -> String {
    "My name is \(name), \(age) years old."
}


/*
 // 함수가 두개이상의 표현식을 가지고 있으면, return 구문 생략 불가
func printIntroduceWord2(name: String, age: Int) -> String {
    let uppername = name.uppercased()
    "My name is \(name), \(age) years old."
}
 */

