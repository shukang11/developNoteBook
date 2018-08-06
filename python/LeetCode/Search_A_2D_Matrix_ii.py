"""
编写一个高效的算法来搜索m x n 矩阵中的一个目标值
该矩阵具有如下特点，
每一行被从左到右排序
每一列被从上到下排序

"""


class Solution:
    def searchMatrix(self, matrix, target):
        if not matrix or len(matrix) == 0: return False
        height = len(matrix)
        width = len(matrix[0])
        if width == 0: return False
        # pick the rows
        targetRows = []
        for rowI in range(height):
            row = matrix[rowI]
            if row[0] <= target and row[width-1] >= target:
                targetRows.append(row)
        for i in range(len(targetRows)):
            for j in range(len(targetRows[0])):
                if target == targetRows[i][j]:
                    return True
        return False

if __name__ == '__main__':
    matrix = [
  []
]
    s = Solution()
    result = s.searchMatrix(matrix, 20)
    print(result)