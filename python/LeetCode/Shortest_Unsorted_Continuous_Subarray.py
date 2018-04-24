"""
给定一个数组，找到最短无序连续子数组，如果对这个子数组进行升序排列，那么这个数组都会变成升序排列

输入: [2, 6, 4, 8, 10, 9, 15]
输出: 5
解释: 你只需要对 [6, 4, 8, 10, 9] 进行升序排序，那么整个表都会变为升序排序。

说明 :

输入的数组长度范围在 [1, 10,000]。
输入的数组可能包含重复元素 ，所以升序的意思是<=。

"""
class Solution(object):
    """
    is_same = [a == b for a, b in zip(nums, sorted(nums))]
        return 0 if all(is_same) else len(nums) - is_same.index(False) - is_same[::-1].index(False)
    """
    def findUnsortedSubarray(self, nums):
        is_same = [a == b for a, b in zip(nums, sorted(nums))] # 将每个不同的索引标记出来
        # 从两边逼近中间，剔除两边的不用排序的，中间的就是需要排序的了
        return 0 if all(is_same) else len(nums) - is_same.index(False) - is_same[::-1].index(False)

if __name__ == '__main__':
    s = Solution()
    print(s.findUnsortedSubarray([2, 6, 4, 8, 10, 9, 15]))
