//: [Previous](@previous)

import Foundation

/*:
 # 프리스쿨1. 구구단
 */

//var dan = 1
//
//while(dan < 10) {
//    for i in 1...9 {
//        if i % 2 == 0 { continue }
//        print("\(dan) * \(i) = \(dan * i)")
//    }
//    dan = dan + 1
//}


/*:
 ## 구구단 개선하기
 */
//:### 1. 배열로 반환받은 결과값을 그대로 출력
func gugudan() {
    for num in 2...9 {
        print(gugu(number: num))
    }
}

func gugu(number : Int) -> [Int] {
    var results = [Int](repeating: 0, count: 9)
    for i in 1...9 {
        results[i-1] = number * i
    }
    return results
}


//: ### 2. Dictionary 로 만들기
// 함수 선언부(callee)
func gugudan(start: Int, end: Int) {
    var dic = [Int: [Int]]()
    for i in start...end {
        dic[i] = gugu(number: i)
    }
    
    for i in start...end {
        guard let items = dic[i] else { continue }
        printGugu(num: i, results: items)
    }
}


func printGugu(num: Int, results: [Int]) {
    print("\(num) 단")
    for (index,result) in results.enumerated() {
        print("\(num) * \(index + 1) = \(result)")
    }
}

// 함수 호출부(caller)
gugudan(start: 2, end: 3)





//: [Next](@next)
