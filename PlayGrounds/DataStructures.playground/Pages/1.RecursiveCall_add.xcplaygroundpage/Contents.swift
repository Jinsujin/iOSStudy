//: [Previous](@previous)

import Foundation

//: # 재귀함수2
//: ## 1~ 100 까지의 합

/*:

 * for in 문
*/
var result = 0

for i in 1...100 {
    result += i
}

print("forin문 결과 : \(result)")



/*:

 * 재귀함수
 
*/

func recursiveAdd(n: Int) -> Int {
    if (n <= 1){
        return 1
    }
    
    return n + recursiveAdd(n: n-1)
}

print("재귀함수 결과 : \(recursiveAdd(n: 100))")



/*:
 
 * 2진수 변환
 
 */


String(11, radix: 2) // 1011

func 이진법(_ n: Int) -> String {
    if (n == 1 || n == 0){
        return "\(n)";
    }
    
    // 몫 + 나머지
    return 이진법(n/2) + String(n % 2)
}

print(이진법(11))


/*:
 * 문자열 뒤집기
 */

var text = "apple" //elppa
for char in text.reversed() {
    print(char, terminator: "")
}


//text.count
//let endIdx = text.endIndex
//let 자른문자열 = text[..<endIdx]
//print(자른문자열)

//let pop = text.popLast()
//print("pop  = \(pop)")
//print("text = \(text)")



let 문자배열 = Array(text)
문자배열[..<2]

func 문자열역순(_ 문자: inout String) -> String {
    if(문자.count == 1) { return 문자 }

    let popChar = 문자.popLast()

    // 마지막 문자 + 재귀(마지막 문자를 뺀 문자열)
    return String(popChar!) + 문자열역순(&문자)
}

문자열역순(&text)


//: [Next](@next)
