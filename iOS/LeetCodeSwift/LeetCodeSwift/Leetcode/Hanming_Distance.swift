//
//  Hanming_Distance.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
/**
 题目： 给定两个数字介于0和2^23之间，判断两个数字之间的汉明距离
 
 tips：汉明距离是使用在数据传输差错控制编码里面的，汉明距离是一个概念，它表示两个（相同长度）字对应位不同的数量，我们以d（x,y）表示两个字x,y之间的汉明距离。对两个字符串进行异或运算，并统计结果为1的个数，那么这个数就是汉明距离。
 思路： 将数字转换成二进制，统计1的个数
 */
extension Solution {
    func hanming_Distance(_ x: Int, _ y: Int) -> Int {
        let diff = String(x^y, radix: 2)
        var count: Int = 0
        for index in diff {
            if index == "1" { count += 1}
        }
        return count
    }
}
