"""
爬楼梯

有一阶梯，需要n步爬上去，每步只能跨一或者二级，有几种方法可以到顶上

e.g:
Input: 2
Output:  2
1. 1步+1步
2. 2步


Input: 3
Output:  3
1. 1步+1步+1步
2. 2步+1步
3. 1步+2步

思路：
在大于2级的前提下，到达当前阶梯的可能的方式有上一级与上上一级的和
"""

class Solution(object):

    def climbingStairs(self, n: int) -> int:
        if n <= 3:
            return n
        steps = [0, 1, 2]
        for index in range(3,n+1):
            steps.append(steps[index-1] + steps[index-2])
        return steps[-1] or 0


if __name__ == '__main__':
    s = Solution()
    result = s.climbingStairs(5)
    print(result)