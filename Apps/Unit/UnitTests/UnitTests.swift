//
//  UnitTests.swift
//  UnitTests
//
//  Created by jsj on 2021/12/01.
//

import XCTest
@testable import Unit

class UnitTests: XCTestCase {
    var sut: Service!

    // 테스트 전 준비
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        try super.setUpWithError()
        sut = Service()
    }

    // 테스트 후
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        // 객체 해제
        sut = nil
//        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            for i in 0 ..< 100000 {
                _ = sut.add(a: 1, b: 2)
            }
        }
    }
    
    func testAddResultCorrect() {
        // given
//          let guess = sut.targetValue + 5
        let a = 1
        let b = 2

          // when
//          sut.check(guess: guess)
        let result = sut.add(a: a, b: b)

          // then
        XCTAssertEqual(result, 3, "Add result is wrong")
    }
}
