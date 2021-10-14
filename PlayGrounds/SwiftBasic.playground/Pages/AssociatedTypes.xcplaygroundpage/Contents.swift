//: [Previous](@previous)

import Foundation

/*:

 * Associated Types
 
*/

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}



struct IntStack: Container {
    var items = [Int]()
    
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }

    
    // Protocol funtions
    // 여기서 Item을 Int로 정의했기때문에, Item은 int type으로 변환된다
    typealias Item = Int
    mutating func append(_ item: Item) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Item {
        return items[i]
    }
    
}

var stack_int = IntStack(items: [1,2,3,4,5])
stack_int.append(10)
print(stack_int.items) //[1, 2, 3, 4, 5, 10]
print(stack_int.pop()) // 10


/*:

 * Generic Type 으로 유연한 구조체 만들기
 
*/

struct Stack<Element>: Container {
//    typealias Item = Int
    
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }

    
    // protocol functions
    mutating func append(_ item: Item) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}

var elem_stack_int = Stack(items: [1,2,3]) // Stack<Int>
var elem_stack_str = Stack(items: ["banana", "apple", "orange"]) //Stack<String>
elem_stack_str.push("blueberry")
print(elem_stack_str.items) //["banana", "apple", "orange", "blueberry"]


extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil: items[items.count - 1]
    }
}

if let topItem = elem_stack_str.topItem {
    print(topItem) // blueberry
}



/*:
 
*
 
 */
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
}

var int_stack = Stack<Int>()
int_stack.append(10)
int_stack.append(20)
int_stack.append(30)
let suffix = int_stack.suffix(2)
print(suffix) // Stack<Int>(items: [20, 30])

//: [Next](@next)
