"""
给定一个n x n的二维矩阵表示一个图像

将图像顺时针旋转90°


必须要在原图像旋转，不要使用另一个矩阵来旋转图像



Given input matrix =
[
  [1,2,3],
  [4,5,6],
  [7,8,9]
],

rotate the input matrix in-place such that it becomes:
[
  [7,4,1],
  [8,5,2],
  [9,6,3]
]

解题思路：
先沿着逆对角线翻转一次，再按照x轴中线翻转一次
 * 1 2 3     7 8 9     7 4 1
 * 4 5 6  => 4 5 6  => 8 5 2
 * 7 8 9     1 2 3     9 6 3


"""


class Solution:
    def rotate(self, matrix):
        """
        要解决翻转的问题
        :param matrix:
        :return:
        """
        if not matrix or len(matrix) == 0:
            return
        n = len(matrix)  # 因为是n x n的，所以长等于宽
        matrix.reverse() #
        #  逆对角线翻转
        for i in range(n):
            for j in range(i):
                matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
        return matrix



if __name__ == '__main__':
    s = Solution()
    result = s.rotate([
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ])
    print(result)