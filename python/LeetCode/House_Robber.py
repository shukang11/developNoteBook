
"""
问题描述：

有一个专业的盗贼，有一列房子，数字表示每个房子可以获得的最大收获。但是不能偷取相邻两个房子，否则就会失败

提示： 动态规划
思路：
动态规划的思路一般是从结局开始入手
如果选择了上一个屋子，那么就不能选择当前屋子，那么最大的收益就是上一个屋子的收益
如果选择当前的屋子，就不能选择上一个屋子，那么最大收益就是上上一个屋子加上当前屋子的收益

当前价值    当前最大      上一个最大     上上一个最大
loop        Yes             No           temp
2           2               0            0
1           1               2            0
1           3               2            2
2           4               3            2

"""

class Solution(object):
    def rob(self, nums):
        if len(nums) <= 0: return 0
        path = []
        # preYes 表示当前的最大收益值
        # preNo 表示上次的最大收益值
        preNo, prevYes = 0, 0
        for n in nums:
            temp = preNo
            preNo = max(preNo, prevYes)
            prevYes = n + temp
        return max(prevYes, preNo)


if __name__ == '__main__':
    nums = [2, 1, 1, 4]
    so = Solution()
    result = so.rob(nums)
    print("Max Value is: {}".format(str(result)))
