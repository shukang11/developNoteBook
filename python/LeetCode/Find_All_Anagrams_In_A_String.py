from collections import Counter
"""
找到所有顺序颠倒的字符

Input:
s: "cbaebabacd" p: "abc"

Output:
[0, 6]

Explanation:
The substring with start index = 0 is "cba", which is an anagram of "abc".
The substring with start index = 6 is "bac", which is an anagram of "abc".

Input:
s: "abab" p: "ab"

Output:
[0, 1, 2]

Explanation:
The substring with start index = 0 is "ab", which is an anagram of "ab".
The substring with start index = 1 is "ba", which is an anagram of "ab".
The substring with start index = 2 is "ab", which is an anagram of "ab".


"""

class Solution(object):

    def findAnagrams1(self,s, p):
        """
        滑动窗口思想，遍历s，判断每一个字符开始的p.size()个字符是否是p的相同字母异序词即可。
        :param s: source
        :param p: parse
        :return: [index]
        """
        res = []
        pCounter = Counter(p) # 将p字符串中字符与次数统计
        sCounter = Counter(s[:len(p)-1])
        for i in range(len(p)-1, len(s)):
            sCounter[s[i]] += 1 # 将新的字符串装填
            if sCounter == pCounter:
                res.append(i-len(p)+1) # 将起始索引装填
            sCounter[s[i-len(p)+1]] -= 1
            if sCounter[s[i-len(p)+1]] == 0:
                del sCounter[s[i-len(p)+1]]
            pass
        return res
    pass

if __name__ == '__main__':
    s = Solution()
    result = s.findAnagrams1('cbaebabacd', 'abc')
    print(result)