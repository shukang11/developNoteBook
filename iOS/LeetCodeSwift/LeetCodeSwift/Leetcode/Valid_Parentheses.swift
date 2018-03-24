//
//  Valid_Parentheses.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/22.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
extension Solution {
    /**
     Question:
         Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
     
         The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.
     */
    /// 见代码
    func isValid(_ s: String) -> Bool {
        var stack: [String] = []
        let pushSyn = ["(", "[", "{"]
        for c in s {
            let sub = String.init(c)
            if pushSyn.contains(sub) {
                stack.append(sub)
            }
            else if sub == ")" && stack.last == "(" && stack.isEmpty == false {
                stack.removeLast()
            }
            else if sub == "]" && stack.last == "[" && stack.isEmpty == false {
                stack.removeLast()
            }
            else if sub == "}" && stack.last == "{" && stack.isEmpty == false {
                stack.removeLast()
            }else { return false }
        }
        return stack.isEmpty
    }
}
