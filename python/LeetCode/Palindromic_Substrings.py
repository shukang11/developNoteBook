
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


    def countSubstringV2(self, s):
        n = len(s)
        # 生成一个
        m = [[False for _ in range(n)] for _ in range(n)]
        w = 1

        for i in range(n):
            # each char is a palindrom
            m[i][i] = True

        for i in range(n-w):
            # if two chars match they are palindrom
            m[i][i+w] = s[i] == s[i+w]

        for w in range(2, n):
            # if 'abxba' is  palindrom 'bxb'is also a lalindrom
            for i in range(n-w):
                m[i][i+w] = m[i+1][i+w-1] \
                            and (s[i] == s[i+w])
        count = 0
        for i in range(n):
            for j in range(n):
                if m[i][j]:
                    count += 1
        return count

if __name__ == '__main__':
    s = Solution()
    print(s.countSubstringV2("aaa"))