"""
给定一个排序号的数组和一个目标数值。如果在数组中找到目标值，返回其索引，如果目标值不存在于数组中，返回其将会被按顺序插入的位置

Example 1:

Input: [1,3,5,6], 5
Output: 2

Example 3:

Input: [1,3,5,6], 7
Output: 4

"""

class Solution:
    def searchInsert(self, nums, target):
        count = len(nums)
        for index in range(count):
            num = nums[index]
            print('index {index} num: {num} target {target}'.format(index=index,num=nums[index],target=target))
            if target > num:
                continue
            else:
                return index
        return count
        pass

if __name__ == '__main__':
    s = Solution()
    result = s.searchInsert([1,2,3,5,6], 7)
    print(result)