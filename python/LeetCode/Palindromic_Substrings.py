
"""
子回文串

"""
class Solution(object):
    def countSubstring(self, s):
        N = len(s)
        ans = 0
        for center in range(2 * N - 1):
            left = int(center / 2)
            right = left + center % 2
            while left >= 0 \
                    and right < N \
                    and s[left] == s[right]:
                print(ans, s[left], left, s[right] ,right)
                ans += 1
                left -= 1
                right += 1
        return ans

if __name__ == '__main__':
    s = Solution()
    print(s.countSubstring("aaa"))