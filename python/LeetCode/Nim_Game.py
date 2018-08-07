"""

Nim 游戏，排列有一组石头，每次可以移走1-3块石头，拿走最后一块石头的将会获胜，你是先手，我的对手也很聪明。不会让着我


Input: 4
Output: false
Explanation: If there are 4 stones in the heap, then you will never win the game;
             No matter 1, 2, or 3 stones you remove, the last stone will always be
             removed by your friend.

如果确定了所有的情况都不能获胜，则判定不能获胜
"""

class Solution:
    def canWinNim(self, n):
        if n <= 0: return False
        winInfo = [0, 1, 1, 1, 0] # 前四次的情况
        remin = n % 4
        return bool(winInfo[remin])


if __name__ == '__main__':
    s = Solution()
    result = s.canWinNim(5)
    print(result)