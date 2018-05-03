import collections
"""

给定一个整型的集合，需要找到子集和为k的数量


思路：
记录从开始到位置i的累计和，在统计位置i之前有多少个累加和等于sum[i]-k

nums: [1, -1, 5, -2, 3], k = 3

sums: [1, 0, 5, 3, 6]
"""

class Solution(object):
    def subarraySum(self, nums, k):
        res, s, n = 0, 0, len(nums)
        counter = collections.Counter()
        counter[0] += 1
        for i in range(0, n):
            s += nums[i]
            res += counter[s-k]
            counter[s] += 1
            print(counter)
        return res


if __name__ == '__main__':
    s = Solution()
    nums = [1, -1, 5, -2, 3]
    k = 2
    result = s.subarraySum(nums, k)
    print(result)