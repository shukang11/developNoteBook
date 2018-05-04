
"""
给定一组非负数，和一个目标S，现在我有+/-两个符号，给每个数添加一个符号，使得加和为S
求共有多少种方法

动态规划：

"""

class Solution(object):
    def findTargetSumWays(self, nums, S):
        if not nums:
            return 0
        dic = {nums[0]: 1, -nums[0]: 1} if nums[0] != 0 else {0: 2}
        for i in range(1, len(nums)):
            tdic = {}
            for d in dic: # 遍历一遍，然后分别计算和与差的结果，并统计
                tdic[d + nums[i]] = tdic.get(d + nums[i], 0) + dic.get(d, 0)
                tdic[d - nums[i]] = tdic.get(d - nums[i], 0) + dic.get(d, 0)
            dic = tdic
        print(dic)
        return dic.get(S, 0)


if __name__ == '__main__':
    s = Solution()
    nums = [1, 1, 1, 1, 1]
    target = 3
    result = s.findTargetSumWays(nums, target)
    print(result)