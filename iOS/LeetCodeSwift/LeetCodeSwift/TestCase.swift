//
//  TestCase.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/12.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation

class TestCase: NSObject {
    func testBegin() {
        let s = Solution.init()
        let result = s.wordBreak("aaaaaaa", ["aa", "aaaa"])
        print("\(result)")
    }
}
