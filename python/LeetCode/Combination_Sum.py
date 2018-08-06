"""
给定一个无重复元素的数组candidates和一个目标数target，找出candidates中所有可以使用数字和为target的组合

1.所有数字嗾使正整数
2.解集不能包含重复的组合


输入: candidates = [2,3,6,7], target = 7,
所求解集为:
[
  [7],
  [2,2,3]
]

深度优先搜索

"""

class Solution:
    def combinationSum(self, candidates, target):
        res = []
        candidates.sort()
        self.helper(candidates, target, [], res)
        return res

    def helper(self, candi, target, cur, res):
        # 如果当前和已经大于目标，说明该路径错误
        print(cur)
        if target < 0:
            return
        if target == 0:
            res.append(cur)
            return
        for i in range(len(candi)):
            self.helper(candi[i:], target-candi[i], cur+[candi[i]], res)


if __name__ == '__main__':
    s = Solution()
    result = s.combinationSum([4,3,2,6], 10)
    print(result)