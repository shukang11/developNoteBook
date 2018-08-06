"""
给定一个排过序的整数数组，找到给定数字的起点位置和终点位置
如果不在数组中，返回[-1, -1]

输入: nums = [5,7,7,8,8,10], target = 8
输出: [3,4]

"""

class Solution:
    def searchRange(self, nums, target):
        minIndex = -1
        maxIndex = -1
        for i in range(len(nums)):
            if nums[i] == target:
                minIndex = i if minIndex == -1 else minIndex
                maxIndex = i
        return [minIndex, maxIndex]
        pass

if __name__ == '__main__':
    nums = [5, 7, 7, 8, 8, 10]
    s = Solution()
    result = s.searchRange(nums, 8)
    print(result)