"""
最大连续

给定二进制数组，返回最长的连续相同的个数

Input: [1,1,0,1,1,1]
Output: 3
"""

class Solution:
    def findMaxConsecutiveOnes(self, nums):
        count = 0
        curr = 0
        for n in nums:
            if n == 1:
                curr += 1
            else:
                curr = 0
            count = max(count, curr)
        return count


if __name__ == '__main__':
    nums = [1,0,1,1,0,1]
    s = Solution()
    result = s.findMaxConsecutiveOnes(nums)
    print(result)