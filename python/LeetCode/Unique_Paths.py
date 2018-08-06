"""
机器人位于网状路线左上角，目标位于左下角，每次只能向右或者向下一步

计算共有集中路线可以到达右下角

Tips：
起点的临边路线都只有一条，所以[m, 0] = [0, n] = 1

每个点的路径数为其左边和上边路径数的和
"""

class Solution:
    def uniquePaths(self, m, n):
        res = [[1 for _ in range(m)] for _ in range(n)]
        for i in range(1,n):# 遍历每行
            for j in range(1,m): # 遍历每行的每个元素
                res[i][j] = res[i-1][j] + res[i][j-1]
        return res[n-1][m-1]

if __name__ == '__main__':
    s = Solution()
    reslut = s.uniquePaths(3, 2)
    print(reslut)