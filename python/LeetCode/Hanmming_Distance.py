"""
汉明码距离


Input: x = 1, y = 4

Output: 2

Explanation:
1   (0 0 0 1)
4   (0 1 0 0)
       ↑   ↑
"""

class Solution(object):
    def hammingDistance(self, x, y):
        diff = bin(x^y)
        return diff.count('1')

if __name__ == '__main__':
    s = Solution()
    result = s.hammingDistance(1, 4)
    print(result)