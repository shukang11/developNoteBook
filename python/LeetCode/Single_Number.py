

'''
Question：只出现一次的数字

给定一个整数数组，除了某个元素外其余元素均出现两次。请找出这个只出现一次的元素。

'''
class Solution:
    def singleNumber(self, nums):
        info: dict = {}
        for n in nums:
            info[n] = info.get(n, 0) + 1
        for (k, v) in info.items():
            if v == 1:
                return k
        return 0