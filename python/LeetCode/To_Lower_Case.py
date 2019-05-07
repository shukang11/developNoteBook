class Solution:
    def toLowerCase(self, str: str) -> str:
        result = ""
        for s in str:
            i = ord(s)
            if i >= 97 and i <= 122: result += chr(i)
            elif i >= 65 and i <= 90: result += chr(i + 32)
            else: result += s
        return result

if __name__ == "__main__":
    s = Solution()
    c = "ssdfSSFDD"
    r = s.toLowerCase(c)
    print(r)