//: [Previous](@previous)

import Foundation

/**
    Subscript
 [] 대괄호를 쓰는 문법. 특별한 형태의 메서드를 호출하는 역할.
 
 array[0]
 dictionary["key"]
 
 */


// MARK:- Example.1
class AClass {
    var datas = ["A", "B", "C", "D", "E"]
    
    // 반드시 파라미터가 필요!
    // 함수와 동일한 형태.
    subscript(index: Int) -> String {
        get {
            return datas[index]
        }
        
        set {
            datas[index] = newValue
        }
    }
}

var aClass = AClass()
print(aClass[0])




// MARK:- Example.2
struct TimesTable {
    let multiplier: Int = 2
    

    // get 만 구현. set 은 생략가능
    subscript(num: Int) -> Int {
        return multiplier * num
    }
}

let timesTable = TimesTable()
print(timesTable[10])




// MARK:- Example.3
struct Matrix {
    var points = [
        ["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]
    ]
    
    subscript(row: Int, column: Int) -> String? {
        if (row >= 3 || column >= 3) {
            return nil
        }
        return points[row][column]
    }
}

var matrix = Matrix()
matrix[0,2]!



// MARK:- Example.4
// Type Subscript - class, struct, enum

enum Planet: Int {
    case mercury = 1, earth, mars, jupiter, saturn
    
    static subscript(num: Int) -> Planet { // Planet ==> Self 대체 가능
        return Planet(rawValue: num) ?? Planet.mercury
    }
}


let earth = Planet[2] // Planet.earth
print(earth)


//: [Next](@next)
