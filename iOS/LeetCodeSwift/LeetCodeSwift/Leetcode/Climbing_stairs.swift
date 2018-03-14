//
//  Climbing_stairs.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/12.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation

extension Solution {
    /**
     You are climbing a stair case. It takes n steps to reach to the top.
     
     Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
     
     Note: Given n will be a positive integer.
     
     当前的可能性为前两级的可能性之和
    */
    func climbStairs(_ n: Int) -> Int {
        if n < 3 { return max(n, 0) }
        var steps: [Int] = [0, 1, 2]
        for index in 3...n {
            steps.append(steps[index-1] + steps[index-2])
            print("第\(index)个\(steps)")
        }
        return steps.last ?? 0
    }
}
