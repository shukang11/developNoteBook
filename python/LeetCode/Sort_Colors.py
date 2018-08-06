"""
对颜色排序

给定一个包含红色、白色、和蓝色一共n个元素的数组，原地对他们进行排序，使得相同的颜色的元素相邻，并按照红白蓝的顺序排好

我们使用0、1、2来表示红白蓝

"""

class Solution:
    def sortColors(self, nums):
        second = len(nums)-1
        zero = 0
        for i in range(len(nums)):
            while i < second and nums[i] == 2:
                nums[i], nums[second] = nums[second], nums[i]
                second -= 1
            while i > zero and nums[i] == 0:
                nums[i], nums[zero] = nums[zero], nums[i]
                zero += 1
        return nums

if __name__ == '__main__':
    colors = [2,0,2,1,1,0]
    s = Solution()
    result = s.sortColors(colors)
    print(result)