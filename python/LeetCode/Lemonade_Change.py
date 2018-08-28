"""
柠檬水找零

每杯水5美元，每位顾客只买一杯，并支付5、10、20，必须正确找零

开始手上没有任何零钱
如果可以找零，返回true，否则返回false

"""

class Solution:
    def lemonadeChange(self, bills):
        mych = {
            5:0,
            10:0,
            20:0
        }
        for b in bills:
            if b == 5:
                mych[5] += 1
            elif b == 10:
                mych[10] += 1
                mych[5] -= 1
            elif b == 20:
                if mych[10] > 0:
                    mych[10] -= 1
                    mych[5] -= 1
                else:
                    mych[5] -= 3
            if mych[5] < 0 or mych[10] < 0 or mych[20] < 0: return False
        return True


if __name__ == '__main__':
    bills = [10,10]
    s = Solution()
    result = s.lemonadeChange(bills)
    print(result)
