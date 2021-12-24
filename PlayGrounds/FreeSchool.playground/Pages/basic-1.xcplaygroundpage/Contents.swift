//: [Previous](@previous)

import Foundation

/*:
  # 학습 목표
 - 기본 데이터 타입 이해하기
 - 프로그램 실행 흐름 제어

 */


/*:
 ### 연습 문제
 
 //빼기 : substract(number1 : Int, number2 : Int) -> Int
 //제곱 : square(number : Int) -> Int
 //나누기 : divide(number : Int, divisor : Int) -> Int

 - 참고:
 [이미 만들어져 있는 함수들](https://swiftdoc.org/v4.2/func/)
 */

func substract(number1 : Int, number2 : Int) -> Int {
    return number1 - number2
}

func square(number : Int) -> Int {
    return number * number
}

func divide(number : Int, divisor : Int) -> Int {
    return number / divisor
}

func add(number1 : Int, number2 : Int) -> Int {
    let sum = number1 + number2
    return sum
}

func add(number1 : Int, number2 : Int, number3 : Int) -> Int {
    return add(number1: number1, number2: number2) + number3
}

add(number1: 123, number2: 234)
substract(number1: 456, number2: 123)
square(number: 8)
divide(number: 256, divisor: 8)


/*:
 ## 데이터 타입, 자료형
 - 데이터 값(value): 컴퓨터가 처리하는(계산하는) 데이터 단위와 종류
    - Int
    - Float, Double
    - String
    - Bool
 
 - 변수variable (mutable): 값을 보관하면서 계속해서 바꿀수 있는 공간 == var
 - 상수constant (Immutable): 처음 값만 넣고 다시 바꿀 수 없는 공간 == let
 
 - 부동 소수형
    - Float: 부호(1자리) + 지수(8자리) + 가수(23자리) = 32비트
    - Double: 부호(1자리) + 지수(11자리) + 가수(52자리) = 64비트
 */

/*:
 ### 연습 문제
 1. inch를 cm로 바꾸는 함수
 - convertToCM(fromInches : Float) -> Float
 
2. cm 를 inch로 바꾸는 함수
 - convertToInches(fromCM : Float) -> Float
 
 3. m를 inch로 바꾸는 함수
 - convertToInches(fromMeter : Float) -> Float
 
 */

func convertToCM(fromInches : Float) -> Float {
    return fromInches * 2.54
}

func convertToInches(fromCM : Float) -> Float {
    return fromCM / 2.54
}

func convertToInches(fromMeter : Float) -> Float {
    return fromMeter * 39.37
}


/*:
 ## 연산자
- 기본 자료형을 계산하기 위해 사용한다.
 - +, -, *, /, &&, ||, ??
 - %: 나머지 연산자. 배수 확인할때 사용한다.

- 연산자 계산 순서: 대부분의 계산은 왼쪽에서 오른쪽으로 진행된다.
    1. 단항 연산자 +, -, !, ~
    2. 산술 연산자 *, /, %
    3. 산술 연산자 +, -
 
 */

// 단항 연산자
var intValue = -10
let result = +intValue // 변수 * (1)
let minus = -intValue // 변수 * (-1)



/*:
 ### 연습 문제
 미션1. Rectangle
 - Playground로 Rectangle struct를 만들어보세요.
 - Int 형 leftTopX, leftTopY 변수를 추가하세요.
 - Int 형 rightBottomX, rightBottomY 변수를 추가하세요.
 - 4개의 꼭지점을 출력하는 printRect() 메서드를 선언하세요.
 
 미션2. 호출하기
 아래에서 Rectangle struct를 rect 변수로 선언하고
 기본 제공하는 leftTopX, leftTopY, rightBottomX, rightBottomY 모두 초기화하는 메서드로 값을 지정하세요.
 printRect() 메서드를 호출해서 꼭지점 좌표를 출력하세요.
 
 미션3. printArea()
 사각형의 면적을 계산해서 출력하는 printArea() 메서드를 추가하세요.
 아래에서 printArea() 메서드를 호출하세요.
 
 미션4. Float형
 사각형 좌표를 Float 형으로 바꿔보세요.
 printRect() 메서드를 호출하세요.
 */


struct Rectangle {
    var leftTopX: Float
    var leftTopY: Float
    var rightBottomX: Float
    var rightBottomY: Float
    
    func printRect() {
        print(
        """
        (\(leftTopX),\(leftTopY))------(\(rightBottomX),\(leftTopY))
        |                      |
        |                      |
        (\(leftTopX),\(rightBottomY))------(\(rightBottomX),\(rightBottomY))
        """
        )
    }
    
    /// 면적 구하기
    func printArea() {
        let h = leftTopY - rightBottomY
        let w = rightBottomX - leftTopX
        print("면적 = ", w * h)
    }
    
    /// 중점 구하기
    func printCenter() {
        let h = leftTopY - rightBottomY
        let w = rightBottomX - leftTopX
        
        let centerX =  w / 2 + leftTopX
        let centerY = h / 2 + rightBottomY
        print("중점 = \(centerX), \(centerY)")
    }
}


//var rect = Rectangle(leftTopX: 5, leftTopY: 11, rightBottomX: 15, rightBottomY: 4)
//rect.printRect()
//rect.printArea()

//let floatRect = Rectangle(leftTopX: 4.5, leftTopY: 10.5, rightBottomX: 15, rightBottomY: 3.5)
//floatRect.printRect()
//floatRect.printCenter()



/*:
 ### 연습 문제2
 
*/

struct MyPoint {
    var myX: Float
    var myY: Float

    func printPoint() {
        print("(\(myX), \(myY))")
    }
    
    mutating func setX(x: Float) {
        self.myX = x
    }
    
    mutating func setY(y: Float) {
        self.myY = y
    }
    
    /// 내점과 다른점 사이의 거리 계산
    func getDistanceTo(toPoint : MyPoint) -> Float {
        let x = toPoint.myX - self.myX
        let y = toPoint.myY - self.myY
        
        // pow() : 제곱 - 예) 3.0 의 2제곱은 9.0 이다.
        // sqrt(): 제곱근 - 예) 9.0 의 제곱근은 3.0 이다.
        // floor(): 버림
        
        let distance = sqrt(pow(x, 2) + pow(y, 2))
        return distance
    }
}

//var pointA = MyPoint(myX: 2.5, myY: 15.8)
//pointA.printPoint()
//pointA.setX(x: 15.2)
//pointA.setY(y: 7.4)
//print("pointA = (\(pointA.myX), \(pointA.myY))")
//
//var pointB = MyPoint(myX: 15, myY: 12.2)
//let distance = pointA.getDistanceTo(toPoint: pointB)
//print(floor(distance))


/*:
 ### 연습문제 3
 
 */

struct Rectangle2 {
    var leftTop: MyPoint
    var rightBottom: MyPoint
    
    var center: MyPoint {
        let centerX =  width / 2 + leftTop.myX
        let centerY = height / 2 + rightBottom.myY
        return MyPoint(myX: centerX, myY: centerY)
    }
    
    var width: Float {
        rightBottom.myX - leftTop.myX
    }
    
    var height: Float {
        leftTop.myY - rightBottom.myY
    }
    
    init() {
        self.leftTop = MyPoint(myX: 0, myY: 0)
        self.rightBottom = MyPoint(myX: 0, myY: 0)
    }
    
    init(_ point: MyPoint, width: Float, height: Float) {
        let halfW = width / 2
        let halfH = height / 2
        self.leftTop = MyPoint(myX: point.myX - halfW, myY: point.myY + halfH)
        self.rightBottom = MyPoint(myX: point.myX + halfW, myY: point.myY - halfH)
    }
    
    func printRect() {
        print(
        """
        (\(leftTop.myX),\(leftTop.myY))------(\(rightBottom.myX),\(leftTop.myY))
        |                      |
        |                      |
        (\(leftTop.myX),\(rightBottom.myY))------(\(rightBottom.myX),\(rightBottom.myY))
        """
        )
    }
    
    /// 면적 구하기
    func printArea() {
        print("면적 = ", width * height)
    }
    
    /// 중점 구하기
    func printCenter() {
        let centerX =  width / 2 + leftTop.myX
        let centerY = height / 2 + rightBottom.myY
        print("중점 = \(centerX), \(centerY)")
    }
    
    mutating func moveTo(delta: MyPoint) {
        let halfW = width / 2
        let halfH = height / 2
        let centerX = self.center.myX + delta.myX
        let centerY = self.center.myY - delta.myY
        self.leftTop = MyPoint(myX: centerX - halfW, myY: centerY + halfH)
        self.rightBottom = MyPoint(myX: centerX + halfW, myY: centerY - halfH)
    }
}


var rectB = Rectangle2(MyPoint(myX: 5, myY: 5), width: 5, height: 10)
rectB.printRect()
rectB.printCenter()
print(rectB.center)
print("-----좌표이동후----")
rectB.moveTo(delta: MyPoint(myX: -1, myY: 2))
rectB.printCenter()
rectB.printRect()

/*:
 ## 프로그램 흐름 제어
 
 */

func whatIsGrade(point : Int) -> Character {
    let result: Character
    if (point >= 90) {
        result = "A"
    } else if (point < 90 && point >= 80) {
        result = "B"
    } else if (point < 80 && point >= 70) {
        result = "C"
    }else if (point < 70 && point >= 60) {
        result = "D"
    } else {
        result = "F"
    }
    return result
}

//print(whatIsGrade(point: 20))


func whatIsGradeSwitch(point : Int) -> Character {
    let result: Character
    switch point {
    case 0..<60:
        result = "F"
    case 60..<70:
        result = "D"
    case 70..<80:
        result = "C"
    case 80..<90:
        result = "B"
    default:
        result = "A"
    }
    return result
}

//print(whatIsGradeSwitch(point: 90))

func gugu(dan : Int) {
// dan 값에 1 ~ 9까지 곱해서 출력하세요
    for i in 1...9 {
        print("\(dan) * \(i) = \(dan * i)")
    }
}

func makeAll() {
// gugu() 함수를 1~9단까지 호출하세요
    for i in 1...9 {
        print("\(i) 단")
        gugu(dan: i)
    }
}

func makeGugu(maxDan : Int) {
// 1단부터 maxDan까지 값에 1 ~ 9까지 곱해서 출력하세요
    for i in 1...maxDan {
        print("\(i) 단")
        gugu(dan: i)
    }
}


//: [Next](@next)
