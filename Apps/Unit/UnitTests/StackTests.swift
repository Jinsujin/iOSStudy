//
//  StackTests.swift
//  UnitTests
//
//  Created by jsj on 2021/12/02.
//

import XCTest
@testable import Unit

class StackTests: XCTestCase {
    var sut: Stack!

    override func setUpWithError() throws {
        // 테스트에 사용할 인스턴스 생성
        sut = Stack()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testIsCreatedEmpty() throws {
        XCTAssertEqual(sut.size, 0)
    }
    
    
    func testPushItem() throws {
        // when
        sut.push(1)

        // then
        XCTAssertEqual(sut.peek(), 1)
    }

    func testPop() throws {
        sut.push(1)
        sut.push(2)
        
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.size, 1)
    }
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
