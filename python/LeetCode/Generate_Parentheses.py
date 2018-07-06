"""

括号生成，给出n代表生成括号的对数，生成可能且有效的组合

不是很明白


To generate all n-pair parentheses, we can do the following:

Generate one pair: ()

Generate 0 pair inside, n - 1 afterward: () (...)...

Generate 1 pair inside, n - 2 afterward: (()) (...)...

...

Generate n - 1 pair inside, 0 afterward: ((...))

I bet you see the overlapping subproblems here. Here is the code:

(you could see in the code that x represents one j-pair solution and y represents one (i - j - 1) pair solution, and we are taking into account all possible of combinations of them)
"""

class Solution(object):
    def generateParenthesis(self, n):
        dp = [[] for i in range(n+1)]
        dp[0].append('')
        for i in range(n+1):
            for j in range(i):
                dp[i] += ['(' + x + ')' + y for x in dp[j] for y in dp[i-j-1]]
                print(j, i, dp)
        return dp[n]

if __name__ == '__main__':
    s = Solution()
    n = 3
    result = s.generateParenthesis(n)
    print(result)