//: [Previous](@previous)

import Foundation

/**
 
 // 원하는 출력

       😀
     😀😀
   😀😀😀
 😀😀😀😀
 
 */

/*
// for 문 반복
for smile in 1...4 {
    for _ in 0...(4 - smile) {
        print("  ", terminator: "")
    }
    for _ in 0...(smile - 1) {
        print("😀", terminator: "")
    }
    print()
}
*/

func printEmoji(_ emoji: Character, repeat num: Int) {
    for i in 0...num {
        let spaceRepeat = num - i
        let emojiRepeat = num - spaceRepeat
        let result = String(repeating: "  ", count: spaceRepeat)
            + String(repeating: emoji, count: emojiRepeat)
        print(result)
    }
}

printEmoji("🐈‍⬛", repeat: 3)







//: [Next](@next)
