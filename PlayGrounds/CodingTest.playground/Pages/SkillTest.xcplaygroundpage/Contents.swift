import UIKit

func solution(_ a:Int, _ b:Int) -> Int64 {
    var result: Int64 = 0
    
    let startIdx = a < b ? a : b
    let endIdx = a > b ? a : b
    
    for i in startIdx...endIdx {
        result += Int64(i)
    }
    
    return result
}

print(solution(3,5))

print(solution(5,3))

print(solution(3,3))


/**
    문자열이 숫자로만 구성되어 있는지 확인해주는 함수
    문자열 s의 길이가 4 혹은 6이고, 숫자로만 구성돼있는지 확인해주는 함수,
 */
func solution2(_ s:String) -> Bool {
    if !(s.count == 4 || s.count == 6) {
        return false
    }
    if let intVal = Int(s) {
        return true
    }
    return false
}

solution2("a234") // False
solution2("1234") // True

