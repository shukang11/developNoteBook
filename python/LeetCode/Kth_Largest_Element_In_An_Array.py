"""
找到数组中第k大的数字

在未排序的数组中找到第k大的数字

输入: [3,2,3,1,2,4,5,5,6] 和 k = 4
输出: 4
"""

class Solution:
    def findKthLargest(self, nums, k):
        nums.sort()
        return nums[len(nums) - k]