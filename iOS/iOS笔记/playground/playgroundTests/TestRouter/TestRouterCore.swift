//
//  TestRouterCore.swift
//  playgroundTests
//
//  Created by tree on 2018/10/31.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import XCTest

class TestRouterCore: XCTestCase {
    override func setUp() {
        super.setUp()
        RouterManager.shared.register(URL.init(string: "/action/log")!) { (params) in
            print("\(params)")
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func testRegister1() {
        guard let url = URL.init(string: "/test/r") else {
            return
        }
        let r = RouterManager.shared.register(url) { (par) in
            XCTAssertNotNil(par["msg"])
            print("\(par)")
        }
        
        XCTAssert(r)
        
        let (p, b) = RouterManager.shared.searchHandler(URL.init(string: "/test/r?msg=11")!)
        b?(p)
    }
    func testRegister2() {
        let url = URL.init(string: "/test/:placeholder")!
        RouterManager.shared.register(url) { (par) in
            XCTAssertNotNil(par["placeholder"])
        }
        let urlT = URL.init(string: "/test/content")!
        let (p, b) = RouterManager.shared.searchHandler(urlT)
        print("\(p)")
        b?(p)
    }
    func testRegisterMix1() {
        let url = URL.init(string: "/test/:placeholder")!
        RouterManager.shared.register(url) {(_) in}
        let url2 = URL.init(string: "/test/conflct")!
        RouterManager.shared.register(url2) {(_) in}
        XCTAssertNil(RouterManager.shared.searchHandler(URL.init(string: "/test/conflct")!).0["placeholder"])
        XCTAssertNotNil(RouterManager.shared.searchHandler(URL.init(string: "/test/content")!).0["placeholder"])
        
    }
}
