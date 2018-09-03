"""
公平的糖果交换

交换两个数组中的一个元素，使得两个数组的总量是相等的

// 先求得平均数
A = [1, 1] # 2
B = [2, 2] # 4

avr: 3

"""

class Solution:
    def fairCandySwap(self, A, B):
        """
        TLE
        :param A:
        :param B:
        :return:
        """
        sa = sum(A)
        sb = sum(B)
        avr = int((sa + sb) / 2.0)
        for a in A:
            offset = sa - a
            con = avr - offset
            for b in B:
                if b == con:
                    return [a, con]

if __name__ == '__main__':
    A = [1, 2] # 2
    B = [2, 3] # 4
    s = Solution()
    result = s.fairCandySwap(A, B)
    print(result)