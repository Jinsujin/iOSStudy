import UIKit

/*

var i = 1

while i <= 100 {
   
    if i % 3 == 0 && i % 5 == 0 {
        print("fizzbuzz")
    } else if i % 3 == 0 {
        print("fizz")
        
    } else if i % 5 == 0 {
        print("buzz")
    } else {
        print(i)
    }
    
    i += 1
}

*/
/*************  STEP 01 ***************/

/*
func fizz(_ i: Int) -> String {
    if i % 3 == 0 {
        return "fizz"
    }
    
    return ""
}

func buzz(_ i: Int) -> String {
    if i % 5 == 0 {
        return "buzz"
    }
    
    return ""
}


func fizzbuzz(_ i: Int)-> String {
    let f = fizz(i)
    let b = buzz(i)
    
    let result = f + b
    
    if result.isEmpty {
        return "\(i)"
    }
    
    return result
}


//var i = 1
//while i <= 100 {
//    let r = fizzbuzz(i)
//    print(r)
//    i += 1
//
//}


func loop(min: Int, max:Int, do f:(Int)-> Void) {
    var i = min
    while i <= max {
        f(i)
        i += 1
    }
}

loop(min: 1, max: 100, do: { i in
    let r = fizzbuzz(i)
    print(r)
})

*/

/*************  STEP 02 ***************/

/*
let fizz = { i in i % 3 == 0 ? "fizz" : "" }
let buzz = { i in i % 5 == 0 ? "buzz" : "" }


 let fizzbuzz : (Int) -> String = { i in  { a, b in b.isEmpty ? a: b }("\(i)", fizz(i) + buzz(i))}
 
//func fizzbuzz(_ i: Int)-> String {
//    let result = fizz(i) +  buzz(i)
//
//    return result.isEmpty ? "\(i)" : result
//}


func fizzbuzz(_ i: Int)-> String {
    let result = fizz(i) +  buzz(i)
 
    let ff : (String, String) -> String = { a, b in b.isEmpty ? a: b }
    
//    func ff(_ a: String, _ b: String) -> String {
//        return b.isEmpty ? a: b
//    }
    
    return ff("\(i)", result)
}



func loop(min: Int, max:Int, do f:(Int)-> Void) {
    var i = min
    while i <= max {
        f(i)
        i += 1
    }
}

loop(min: 1, max: 100, do: { i in
    let r = fizzbuzz(i)
    print(r)
})
*/

/*************  STEP 03 ***************/

let fizz = { i in i % 3 == 0 ? "fizz" : "" }
let buzz = { i in i % 5 == 0 ? "buzz" : "" }

let fizzbuzz : (Int) -> String = { i in  { a, b in b.isEmpty ? a: b }("\(i)", fizz(i) + buzz(i))}


func loop(min: Int, max:Int, do f:(Int)-> Void) {
    // Array 로 루프를 돌리고, 각 인덱스의 접근은 forEach 를 통함
    Array(min...max).forEach(f)
}


loop(min: 1, max: 100, do: { print(fizzbuzz($0)) })
