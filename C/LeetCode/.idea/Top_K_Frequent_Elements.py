"""
给定一个非空的整数集合，返回其中出现频率前k高 的元素

"""

class Solution(object):
    def topFrequent(self, nums, k):
        info = {}
        for n in nums:
            info.update({str(n): info.get(str(n), 0)+1})
        sortInfo = sorted(info.items(), key=lambda s: s[1], reverse=True)
        return [int(n[0]) for n in sortInfo[: k]]



if __name__ == '__main__':
    s = Solution()
    nums = [1,1,1,2,2,3]
    k = 2
    result = s.topFrequent(nums, k)
    print(result)