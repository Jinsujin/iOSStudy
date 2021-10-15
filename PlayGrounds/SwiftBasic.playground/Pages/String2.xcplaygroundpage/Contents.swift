//: [Previous](@previous)

import Foundation


//MARK:- 문자열을 배열로 변환
/**===============================
 String <==> [String]
 String <==> [Character]
 ===============================**/

// map을 가장 많이 사용
var str = "Swift"
var array: [String] = str.map {String($0)}
print(array)

let array2: [Character] = Array(str)

// [String] => String
let newStr = array.joined()


// [Character] => String
let newStr2 = String(array2)


// 문자열 섞기
let shuffleStr = "Orange"
let shuffledStr = shuffleStr.map { String($0) }.shuffled().joined()
print(shuffleStr)


// 문자열중 문자 하나를 반환
shuffleStr.randomElement()


//MARK:- 대소문자 변환
let 문자 = "appLe"
문자.lowercased() //apple
문자.uppercased() //APPLE

// 맨 앞글자만 대문자로 바꿔서 리턴
문자.capitalized //Apple


// 문자열 비교
"swift" == "Swift" // false
"swift".lowercased() == "Swift".lowercased() // true


// 빈문자열 ""은 nil 이 아니다!


/**===============================
 String 의 인덱스 타입
 
 배열은 인덱스가 있다.

 - 문자열도 Array, Dictionary처럼  Collection 프로토콜을 따르고 있다.

 ===============================**/

let greeting = "Guten Tag!"

let startIdx: String.Index = greeting.startIndex
print(startIdx) //Index(_rawBits: 1)

// 문자열의 서브스크립트로 접근
//greeting[0] // 안됨!
greeting[startIdx]
// G


// index() : 인덱스를 뽑아내는 메서드
// 시작 인덱스에서 +2만큼 떨어진 인덱스를 반환
var index = greeting.index(greeting.startIndex, offsetBy: 2)
greeting[index] //t

// index(after:) 인덱스의 다음번쨰 인덱스 반환
index = greeting.index(after: greeting.startIndex)
greeting[index] //u

// index(before:)
index = greeting.index(before: greeting.endIndex)
greeting[index]  // !


// 인덱스들의 배열
for idx in greeting.indices {
    print(greeting[index])
}

// 위와 같음
//for char in greeting {
//    print(char)
//}



// 공백 문자의 다음문자 뽑아내기
var firstIndex = greeting.firstIndex(of: " ")!
var nextOfEmptyIndex = greeting.index(firstIndex, offsetBy: 1)
greeting[nextOfEmptyIndex]


// 3번째 글자 뽑아내기
var thirdCharIndex = greeting.index(greeting.startIndex, offsetBy: 2)
var thirdChar = greeting[thirdCharIndex]


// 인덱스가 배열 범위를 넘어가면 에러가 발생하므로 주의할것!
//greeting[greeting.endIndex] // error! 아무것도 저장되어있지 않음
//greeting[greeting.index(greeting.endIndex, offsetBy: -1)]
greeting[greeting.index(before: greeting.endIndex)]


// 뽑아낸 인덱스가 올바른 인덱스인지 if문으로 범위 체크
let someIndex = greeting.index(greeting.startIndex, offsetBy: 7)
if greeting.startIndex <= someIndex
    && someIndex < greeting.endIndex {
    print(greeting[someIndex])
}

//
//for i in greeting.indices {
//    print(i)
//}


// 문자열 범위 추출
let lower = greeting.index(greeting.startIndex, offsetBy: 2) //t
let upper = greeting.index(greeting.startIndex, offsetBy: 5) //n
greeting[lower...upper]
//ten


// range로 문자열의 인덱스 범위 추출
var range = greeting.range(of: "Tag!")!
greeting[range]

// 많이 사용하는 range 메서드
//greeting.range(of: <#T##StringProtocol#>)
//greeting.range(of: <#T##StringProtocol#>, options: <#T##String.CompareOptions#>)

// 대소문자 상관없이(option) "tag" 문자열의 범위
range = greeting.range(of: "tag", options: [.caseInsensitive])!
greeting[range]
    

// 거리가 얼마나 떨어져있는지 Int형태로 알려준다
var distance: Int = greeting.distance(from: lower, to: upper)
print(distance)




/**===============================
 삽입, 교체, 추가, 삭제
 ===============================**/

// MARK:- 삽입
var welcome = "Hello"

// 문자로 삽입
welcome.insert("Q", at: welcome.index(after: welcome.startIndex))

// 문자열로 삽입
welcome.insert(contentsOf: "there!", at: welcome.index(after: welcome.startIndex))





// MARK:- 교체
if let range: Range<String.Index> = welcome.range(of: " there!") {
    welcome.replaceSubrange(range, with: " Swift!")
    print(welcome)
}

// 원본은 그대로 두고 반환
var newWelcome = welcome.replacingOccurrences(of: "Swift", with: "World")
print(welcome)
print(newWelcome)

// 대소문자 구분하지 않고 단어를 찾아서 새로운 단어(with)로 변경
newWelcome = welcome.replacingOccurrences(of: "swift", with: "New World", options: [.caseInsensitive], range: nil)
print(newWelcome)




// MARK:- 추가
welcome.append("?")
welcome += "!!"



// MARK:- 삭제
print("삭제전", welcome)
welcome.remove(at: welcome.index(before: welcome.endIndex))
print("삭제후", welcome)

// 문자열 범위
var range2 = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range2)
welcome


//welcome.removeAll()
//welcome.removeAll(keepingCapacity: true)



// MARK:- Example) 삽입과 삭제
var 문자열 = "Hello world"

// 공백문자의 인덱스 가져오기
if let someIndex: String.Index = 문자열.firstIndex(of: " ") {
    문자열.insert(contentsOf: " super", at: someIndex)
    // "Hello super world"
}

if let firstIndex = 문자열.firstIndex(of: " ") {
    // " super" 문자열의 범위 가져와서 삭제
    let range = firstIndex...문자열.index(firstIndex, offsetBy: 5)
    문자열.removeSubrange(range)
    print(문자열) // "Hello world"
}

if let range = 문자열.range(of: " world") {
    문자열.removeSubrange(range)
    print(문자열)
}




//: [Next](@next)
