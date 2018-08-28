"""
电话号码组合的字母组合

给定一个包含数字2-9的字符串，返回能表示的所有字母组合

"""

class Solution:
    def letterCombinations(self, digits):
        if len(digits) == 0: return []
        infos = ["abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]
        result = [""]
        for index in range(len(digits)):
            while len(result[0]) != index+1:
                string = result[0]
                del result[0]
                for letter in infos[int(digits[index])-2]:
                    result.append(string + letter)
        return result

if __name__ == '__main__':
    digits = "23"
    s = Solution()
    result = s.letterCombinations(digits)
    print(result)