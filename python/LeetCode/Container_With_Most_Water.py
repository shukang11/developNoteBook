"""
给定 n 个非负整数 a1，a2，...，an，每个数代表坐标中的一个点 (i, ai) 。
在坐标内画n条垂直线i，两端分别是(1, ai)和(i, 0)，找出其中两条线，
使得他们同x轴构成的容器可以容纳最多的水

输入: [1,8,6,2,5,4,8,3,7]
输出: 49

各自逼近更高的
"""


class Solution:
    def maxArea(self, height):
        i = 0
        j = len(height) - 1
        max_area = 0
        while i < j:
            width = abs(i-j)
            if height[i] < height[j]:
                h = height[i]
                i += 1
            else:
                h = height[j]
                j -= 1
            max_area = max(max_area, h*width)
        return max_area


def main():
    heights = [1,8,6,2,5,4,8,3,7]
    s = Solution()
    result = s.maxArea(heights)
    print(result)

if __name__ == '__main__':
    main()
