"""
给定两个字符串，s, t
t由s随机重排，然后在随机位置添加了一个字母
找出t中被添加的字母

"""

class Solution:
    def findTheDifference(self, s, t):
        sl = list(s)
        tl = list(t)

        while len(sl) > 0:
            p = sl.pop()
            tl.remove(p)
        return ''.join(tl)

if __name__ == '__main__':
    a = "abcd"
    t = "abcde"
    s = Solution()
    result = s.findTheDifference(a,t)
    print(result)