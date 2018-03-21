//
//  Word_Break.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/21.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation

extension Solution {
    /**
     返回真的情况为：当前游标所在位置的前提中 0<n<i
     [0, n]在字典中 - if n < i: [n, i]也在字典中
     
     
     In Python:
     
     d = [False] * len(s)
     # 对每个元素做循环
     for i in range(len(s)):
     # 针对每个索引，判断在你字典中的每个元素的符合条件
        for w in wordDict:
     # 条件为：(单词 等于 当前索引为最后的子字符串) 并且 满足 (是第一个匹配的子字符串 或者 上一个字符串也符合条件)
            if w == s[i-len(w)+1:i+1] and (d[i-len(w)] or i - len(w) == -1 ):
                d[i] = True
     return d[-1]
     */
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        return false
    }
}
