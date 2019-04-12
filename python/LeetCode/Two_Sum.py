"""
给定一个数字的数组，返回两个数字的索引，是的这两个数字的和正好是目标值


Example:
Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].

思路，利用hashtable保存每个数字的计算信息，其中 key 是to_find， value 是cur的索引

"""

class Solution(object):
    def twoSum(self, nums: [int], target: int) -> [int]:
        result = [] # 结果集合
        info = {} # 中间计算的记录
        for index in range(len(nums)):
            cur = nums[index]
            to_find = target - cur
            if cur in info.keys():
                result.append(info[cur])
                result.append(index)
            else:
                info[to_find] = index
            print(str(info) + 'index is' + str(index))
        return result

if __name__ == '__main__':
    nums = [2, 7, 11, 15]
    target = 9
    s = Solution()
    result = s.twoSum(nums, target)
    print(result)