"""
完美平方数

给一个数，找到可以加和为此数的平方数的最小个数

"""

class Solution:
    def numSquares(self, n):
        dp = [i for i in range(n+1)]
        squares = [i*i for i in range(1, int(n**0.5)+1)]
        for i in range(1, n+1):
            for sq in squares:
                if i < sq:
                    continue
                dp[i] = min(dp[i], dp[i-sq]+1)
        return dp[n]




if __name__ == '__main__':
    n = 8285
    s = Solution()
    result = s.numSquares(n)
    print(result)