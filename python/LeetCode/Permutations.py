"""
给定一组不重复的值，返回所有可能的排列

递归实现

"""

class Solution:
    def permute(self, nums):
        self.res = []
        sub = []
        self.dfs(nums, sub)
        return self.res


    def dfs(self, nums, subList):
        if len(subList) == len(nums):
            # 如果组成的组合长度等于给定的，就添加到res中
            self.res.append(subList[:])
        else:
            for n in nums:
                # 否则就一个个添加进去, 如果已经在组合中，就忽略
                if n in subList:
                    continue
                subList.append(n) # 添加一个没有的
                self.dfs(nums, subList)
                subList.remove(n) # 处理之后移除

if __name__ == '__main__':
    s = Solution()
    result = s.permute([1,2,3])
    print(result)