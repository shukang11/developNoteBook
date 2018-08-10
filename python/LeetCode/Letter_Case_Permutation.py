"""
给定一个字符串S，返回所有大小写区分的所有可能

"""

class Solution:
    def letterCasePermutaion(self, S):
        result = [['']]

        nums = [str(i) for i in range(10)]
        def isNum(c):
            return c in nums

        for i in range(len(S)):
            c = S[i]
            r: list = result[i]
            if isNum(c) == False:
                temp = []
                for ri in r:
                    temp.append("{}{}".format(ri, c.upper()))
                    temp.append("{}{}".format(ri, c.lower()))
                result.append(temp)
            else:
                temp = []
                for ri in r:
                    temp.append("{}{}".format(ri, c))
                result.append(temp)

        return result[-1]


if __name__ == '__main__':
    S = "a1b2"
    s = Solution()
    result = s.letterCasePermutaion(S)
    print(result)