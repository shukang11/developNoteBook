//
//  House_Robber.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/15.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
extension Solution {
    
    /**
     复杂度： 时间O(N) / 空间O(1)
     关键词： 动态规划
     过程：如果抢劫了上一个屋子，那么就不能抢劫当前的屋子，所以最大收益为上一个屋子的收益
        如果选择抢劫了当前屋子，就不能抢劫上一个屋子，所以最大收益是上上个屋子的最大收益加上当前屋子的收益
     */
    func rob(_ nums: [Int]) -> Int {
        if nums.count <= 1 { return nums.count == 0 ? 0 : nums[0] }
        var forwardMax = nums[0]
        var currentMax = max(nums[0], nums[1])
        for n in nums {
            let temp = currentMax
            currentMax = max(currentMax, forwardMax + n)
            forwardMax = temp
        }
        return currentMax
    }
}
