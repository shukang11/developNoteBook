//
//  Best_Time_To_Buy_And_Sell_Stone.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/10.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation

class Solution: NSObject {
    
    /**
     question:
     Say you have an array for which the ith element is the price of a given stock on day i.
     
     If you were only permitted to complete at most one transaction (ie, buy one and sell one share of the stock), design an algorithm to find the maximum profit.
     Example:
         Input: [7, 1, 5, 3, 6, 4]
         Output: 5
     
         max. difference = 6-1 = 5 (not 7-1 = 6, as selling price needs to be larger than buying price)
     
         Input: [7, 6, 4, 3, 1]
         Output: 0
     
         In this case, no transaction is done, i.e. max profit = 0.
     找到买入和卖出的最佳时间
     */
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 0 else { return 0 }
        var totolMax: Int = 0
        var sofarMax: Int = prices.first!
        for p in prices {
            if p > sofarMax {
                let result = max(totolMax, p-sofarMax)
                totolMax = result
            }else {
                sofarMax = p
            }
        }
        return 0
    }
}
