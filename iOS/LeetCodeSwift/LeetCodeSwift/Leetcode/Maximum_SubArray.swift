//
//  Maximum_SubArray.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/14.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation

extension Solution {
    func maxSubArray_InOn(_ nums: [Int]) -> Int {
        var totolSum = nums[0]
        var result = nums[0]
        for num in nums {
            totolSum = max((totolSum + num), num)
            result = max(result, totolSum)
        }
        return result
    }
}
