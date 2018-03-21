//
//  Two_Sum.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
/**
 题目： 给定一个数组，和一个目标值，找到两个数字的和为这个目标
        返回两个数字的下标
 
 思路： 利用hashtable， 其中key作为差值， value作为index存储
 */
extension Solution {
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var result: [Int] = []
        var info: [String: Int] = [:]
        for index in 0...(nums.count - 1) {
            let cur = nums[index]
            let to_find = target - cur
            if info.keys.contains("\(to_find)") {
                result.append(info["\(to_find)"]!)
                result.append(index)
            }else {
                info["\(cur)"] = index
            }
        }
        return result
    }
}
