"""
检测大写字母

给定一个单词，判断是否使用了正确的大小写

1.全部字母都是大写
2.单词中都不是大写
3.不只有一个字母，只有首字母大写

否则 不正确

"""

class Solution:
    def detectCapitalUse(self, word):
        l = []
        n = len(word)
        for w in word:
            if w.islower():
                l.append(0)
            else:
                l.append(1)
        return sum(l) == n or \
               (sum(l) == 1 and l[0] == 1) or \
               sum(l) == 0


if __name__ == '__main__':
    word = "USA"
    s = Solution()
    result = s.detectCapitalUse(word)
    print(result)