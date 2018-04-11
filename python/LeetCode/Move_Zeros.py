"""
移动0

将所有的0都移动到最后去

要求不能创建多余的空间


"""

class Solution(object):

    def moveZeros(self, nums:[int]):
        zeroPos = 0
        for i in range(len(nums)):
            if nums[i] != 0:# swich
                print("swich " + str((nums[i], nums[zeroPos])))
                nums[i], nums[zeroPos] = nums[zeroPos], nums[i]
                zeroPos += 1
                print(str(nums) + 'zeroPos -> ' + str(zeroPos) + '\n')


if __name__ == '__main__':
    s = Solution()
    l = [1,6,0,7,6,4,6,0,3,50,2]
    s.moveZeros(l)
    print(l)