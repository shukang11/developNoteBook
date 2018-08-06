"""
给定一个字符串的数组,将字母异位的词组合在一起


输入: ["eat", "tea", "tan", "ate", "nat", "bat"],
输出:
[
  ["ate","eat","tea"],
  ["nat","tan"],
  ["bat"]
]

"""

class Solution:
    def groupAnagrams(self, strs):
        d = {}
        for w in sorted(strs):
            key = tuple(sorted(w))
            d[key] = d.get(key, []) + [w]
        return d.values()

if __name__ == '__main__':
    k = ["eat","tea","tan","ate","nat","bat"]
    s = Solution()
    result = s.groupAnagrams(k)
    print(result)