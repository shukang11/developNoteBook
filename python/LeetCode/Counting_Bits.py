
"""
统计数字的二进制的和

e.g:
num=5
 :return [0,1,1,2,1,2]
 在循环中，在循环数的二进制表示中， 1出现的次数分别为0,1,1,2,1,2次

"""

class Solution(object):

    def countingBits(self,nums) -> [int]:
        result = []
        for index in range(nums+1):
            bina = bin(index)
            result.append(bina.count('1'))
        return result

if __name__ == '__main__':
    s = Solution()
    re = s.countingBits(5)
    print(re)
