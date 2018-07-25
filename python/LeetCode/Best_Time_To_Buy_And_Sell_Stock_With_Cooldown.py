"""
最佳买卖的时机(包含冷冻期)

给定一个整数数组，其中第i个元素代表第i天的股票价格

设计一个算法计算出最大利润，在满足约束的条件下，需要尽可能的完成更多交易(多次买卖一支股票)

条件：
1. 不能同时参与多笔买卖（必须在再次购买之前出售掉之前的股票）
2. 卖出股票后，无法在第二天买入股票(1天的冷冻期)

示例：
Input: [1,2,3,0,2]
output: 3
解释： [买入， 卖出， 冷冻期，买入，卖出]


思路：
状态转移方程

因为最终手里需要没有股票，最终的结果是sell，对于每一天，可以记录下买入和卖出的最大收益
对于sell，取决于前一天
sell[i] = max(sell[i-1], buy[i-1] + prices[i])

buy[i] = max(buy[i-1], sell[i-2] - prices[i])

"""

class Solution:
    # O(n)
    def maxProfit(self, prices):
        if not prices or len(prices) == 0:
            return 0
        sell = []
        buy = []
        sell.append(0)
        buy.append(-prices[0])
        for i in range(1, len(prices)):
            current_sell = int(buy[i-1] + prices[i])
            prev_sell = int(sell[i-1])
            sell.append(max(prev_sell, current_sell))
            buy.append(max(buy[i-1], (sell[i-2] if i > 1 else 0) - prices[i]))
        return sell[len(prices) - 1]
        pass

if __name__ == '__main__':
    s = Solution()
    result = s.maxProfit([1,2,3,0,2])
    print(result)