"""
找到重复的数字

"""

class Solution:
    def findDuplicate(self, nums):
        info = {}
        for n in nums:
            if info.get(n):
                return n
            info.setdefault(n, 1)


if __name__ == '__main__':
    s = Solution()
    result = s.findDuplicate([3, 1, 3, 4, 2])
    print(result)