//: [Previous](@previous)

import Foundation
import XCTest

struct Todo {
    
}


class TodoTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testTodo() {
        XCTAssertNotNil(Todo())
    }
  
    func testExample() {
        XCTAssertEqual("1", "1")
    }
}

//defaultTestSuite: 클래스의 모든 테스트에 대한 테스트 케이스가 들어있는 테스트 세트
// 모든 테스트를 실행한다.
TodoTests.defaultTestSuite.run()

//: [Next](@next)
