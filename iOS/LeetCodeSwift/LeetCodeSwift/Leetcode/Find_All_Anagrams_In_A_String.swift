//
//  Find_All_Anagrams_In_A_String.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/23.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation

extension Solution {
    /**
     找到所有翻转的字符串。
     Example:
         Input:
         s: "abab" p: "ab"
     
         Output:
         [0, 1, 2]
     
         Explanation:
         The substring with start index = 0 is "ab", which is an anagram of "ab".
         The substring with start index = 1 is "ba", which is an anagram of "ab".
         The substring with start index = 2 is "ab", which is an anagram of "ab".
     
     
     Py3 Solution:
         res = []
         n, m = len(s), len(p)
         if n < m: return res
         phash, shash = [0]*123, [0]*123
         for x in p:
            phash[ord(x)] += 1
         for x in s[:m-1]:
            shash[ord(x)] += 1
         for i in range(m-1, n):
            shash[ord(s[i])] += 1
             if i-m >= 0:
                shash[ord(s[i-m])] -= 1
             if shash == phash:
                res.append(i - m + 1)
         return res
     */
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        if s.count == 0 || p.count == 0 { return [] }
        
        return []
    }
}
