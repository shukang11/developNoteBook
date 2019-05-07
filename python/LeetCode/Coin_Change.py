"""

给定不同面额的硬币，和一个总金额，计算可以凑成总金额所需要的最少的硬币个数，如果没有办法能组成总金额返回-1

递归思想
"""

class Solution(object):
    def coinChange(self, coins, amount):
        rt = [-1] * (amount + 1)
        rt[0] = 0
        for i in range(amount + 1): # 从0开始遍历
            for j in coins: # 在备选的硬币中，如果硬币大于i，则不可用；
            #如果此硬币在计算过的rt中找到了符合的，则可以通过,
                if j > i:
                    continue
                if rt[i-j] != -1:
                    if rt[i] == -1:
                        rt[i] = rt[i-j] + 1
                    else:
                        rt[i] = min(rt[i], rt[i-j] + 1)
        return rt[-1]

if __name__ == '__main__':
    s = Solution()
    coins = [1, 2, 5]
    amount = 11
    result = s.coinChange(coins, amount)
    print(result)
