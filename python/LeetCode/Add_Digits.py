"""
给定一个数，将每位数字相加直到只有一位数


"""

class Solution:
    def addDigits(self, num):

        def helper(n):
            return sum(map(int, str(n)))

        result = num
        while result > 9:
            result = helper(result)
        return result




if __name__ == '__main__':
    s = Solution()
    result = s.addDigits(38)
    print(result)
    print(38 // 10)