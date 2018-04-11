"""
寻找最大子串

例如：
示例数组为： [-2,1,-3,4,-1,2,1,-5,4],
最大的子串和为： [4,-1,2,1] 和为6
结果为： 6

策略：
对比正在记录的子串和，如果当前的值大于当前子串，就从当前值开始重新记录
"""

class Solution(object):

    def maxSubArray(self, nums) -> int:
        totolSum = 0
        result = nums[0]
        for num in nums:
            # 取当前值与totolSum加上当前值的较大值
            totolSum = max(totolSum+num, num)
            result = max(totolSum, result)
            print("当前循环到：{0}, totolSum: {1}, result: {2}".format(num, totolSum, result))
        return result


if __name__ == '__main__':
    s = Solution()
    action = [-2,1,-3,4,-1,2,1,-5,4]
    result = s.maxSubArray(action)

