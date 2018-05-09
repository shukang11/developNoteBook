"""
相同子集分割


给定一组非空的正整数，找到两个子数组，他们的和是相等的
Input: [1, 2, 3, 5]

Output: false

Input: [1, 5, 11, 5]

Output: true

动态规划，状态转移方程
"""

class Solution(object):
    def canPartition(self, nums):
        possible_sums = {0}
        for n in nums:
            possible_sums.update({(v + n) for v in possible_sums})
        return (sum(nums)/2.) in possible_sums



if __name__ == '__main__':
    s = Solution()
    nums = [1, 5, 11, 5]
    result = s.canPartition(nums)
    print(result)