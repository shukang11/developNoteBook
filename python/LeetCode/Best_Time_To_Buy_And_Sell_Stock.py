"""
宝石最优的购买和销售时机

Input: [7, 1, 5, 3, 6, 4]
Output: 5

max. difference = 6-1 = 5 (not 7-1 = 6, as selling price needs to be larger than buying price)

Input: [7, 6, 4, 3, 1]
Output: 0

In this case, no transaction is done, i.e. max profit = 0.

思路：
循环一次，分别记录目前为止的最大收益sofarMax，以及实际的最大收益totolMax(最终的返回值)

针对每个循环值：尝试更新最大收益，同时更新最小的进价值
"""

class Solution(object):
    def maxProfit(self, prices:[int]) -> int:
        if prices is None: return 0
        totolMax, low = 0, prices[0]
        for p in prices:
            totolMax = max(totolMax, p-low)
            low = min(low, p)
        return totolMax

if __name__ == '__main__':
    s = Solution()
    result = s.maxProfit([7, 1, 5, 3, 6, 4])
    print(result)