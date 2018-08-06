"""
最小路径和

给定一个m x n 的非负整数的网格，请找出一条从左上角到右下角的路径，使得路径上的数字总和最小

动态规划
当前的最小路径是
"""

class Solution:
    def minPathSum(self, grid:list):
        if not grid: return 0
        height = len(grid)
        width = len(grid[0])
        paths = [[1 for _ in range(width)] for _ in range(height)]
        for i in range(height):
            for j in range(width):
                if i == 0 and j == 0:
                    paths[i][j] = grid[i][j] # 第一列和第一行为原数
                    continue
                if i == 0 and j != 0:
                    paths[i][j] = paths[i][j-1] + grid[i][j]
                    continue
                if i != 0 and j == 0:
                    paths[i][j] = paths[i-1][j] + grid[i][j]
                    continue
                paths[i][j] = min(paths[i-1][j], paths[i][j-1]) + grid[i][j]
        return paths[height-1][width-1]

        pass

if __name__ == '__main__':
    s = Solution()
    grid = [
        [1, 3, 1],
        [1, 5, 1],
        [4, 2, 1]
    ]
    result = s.minPathSum(grid=grid)
    print(result)