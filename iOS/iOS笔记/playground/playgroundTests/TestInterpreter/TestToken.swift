//
//  TestToken.swift
//  playgroundTests
//
//  Created by tree on 2018/10/26.
//  Copyright © 2018 treee. All rights reserved.
//

import XCTest
@testable import playground

class TestToken: XCTestCase {
    override func setUp() {

    }

    override func tearDown() {

    }

    func testInt() {
        XCTAssertEqual(Token.init(type: .integer, value: "11").type, TokenType.integer)
        XCTAssertEqual(Token.init(type: .leftParent, value: "(").type, TokenType.leftParent)
        XCTAssertEqual(Token.init(type: .rightParent, value: ")").type, TokenType.rightParent)
        XCTAssertEqual(Token.init(type: .plus, value: "+").type, TokenType.plus)
        XCTAssertEqual(Token.init(type: .minus, value: "-").type, TokenType.minus)
        XCTAssertEqual(Token.init(type: .multiply, value: "*").type, TokenType.multiply)
        XCTAssertEqual(Token.init(type: .divide, value: "/").type, TokenType.divide)
    }

}

