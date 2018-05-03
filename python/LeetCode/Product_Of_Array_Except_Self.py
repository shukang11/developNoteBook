"""

除了自己的乘积

For example, given [1,2,3,4], return [24,12,8,6].
"""

class Solution(object):
    def productExceptSelf(self, nums):
        """
        out of times
        :param nums:
        :return:
        """
        result = []
        for i in range(len(nums)):
            tn = nums
            loo = 1
            for j in range(len(tn)):
                if i == j:
                    continue
                loo = loo * tn[j]
            result.append(loo)
        return result

    def productExceptSelfV2(self, nums):
        """
        思路1
        我们以一个4个元素的数组为例，nums=[a1, a2, a3, a4]。
        想在O(n)时间复杂度完成最终的数组输出，res=[a2*a3*a4, a1*a3*a4, a1*a2*a4, a2*a3*a4]。

        比较好的解决方法是构造两个数组相乘：

        [1, a1, a1*a2, a1*a2*a3]
        [a2*a3*a4, a3*a4, a4, 1]
        :param nums:
        :return:
        """
        if not nums:
            return []
        n = len(nums)
        result = [1]*n
        for i in range(1, n):
            result[i] = result[i-1] * nums[i-1]
        right = 1
        for i in reversed(range(n)):
            result[i] *= right
            right *= nums[i]
        return result


if __name__ == '__main__':
    s = Solution()
    print(s.productExceptSelfV2([1,2,3,4]))