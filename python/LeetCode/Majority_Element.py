"""
给定一个n的数组，出现次数最多的数字 次数大于（n/2）次

"""

class Solution(object):
    def majorityElementV1(self, nums) -> int:
        """
        生存方法

        设置一个游标，如果出现的了相同的数字那么count增加。否则减少
        结果是如果有一个元素出现的次数符合要求，那么会保证ret会生存下来。
        前提是出现次数要大于(n/2)!

        :param nums:
        :return:
        """
        count, ret = 0, 0
        for n in nums:
            if count == 0:
                ret = n
            if n != ret:
                count -= 1
            else:
                count += 1
        return ret

    def majorityElementV2(self, nums) -> int:
        """
        Map Version
        :param nums:
        :return:
        """
        info = {} # 记录对应的数字和出现的次数
        for n in nums:
            if n not in info.keys():
                info[n] = 1
            else:
                info[n] = info[n] + 1
        items = info.items()
        backlists = [[v[0], v[1]] for v in items]
        backlists = sorted(backlists, key=lambda s:s[1], reverse=True) # 按照值排序，降序
        return backlists[0][0]

if __name__ == '__main__':
    s = Solution()
    result = s.majorityElementV1([1,1,4,5,5,1])
    re = s.majorityElementV2([1,1,4,5,5])
    print(result, re)