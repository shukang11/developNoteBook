"""
给定两个字符串，A,B
A的操作旋转就是将A的最左边字符移动到最右边，
如果在若干次移动之后，A可以变成B，则返回True

"""

class Solution:
    def rotateString(self, A, B):
        la = len(A)
        lb = len(B)
        if la != lb: return False
        if la == 0: return True
        i = 0
        while i < la:
            A = A[1:]+A[0]
            print(A)
            if A == B: return True
            i += 1
        return False


if __name__ == '__main__':
    A = ""
    B = ""
    s = Solution()
    result = s.rotateString(A, B)
    print(result)