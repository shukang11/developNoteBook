

'''
有效的括号

给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。

括号必须以正确的顺序关闭，"()" 和 "()[]{}" 是有效的但是 "(]" 和 "([)]" 不是。

'''
class Solution(object):
    def isValid(self, s: str) -> bool:
        stack = []
        info = {')': '(',
                ']': '[',
                '}': '{'}
        for char in s:
            if char in info.values():
                stack.append(char)
            elif char in info.keys():
                if stack == [] or info[char] != stack.pop():
                    return False
            else:
                return False
        return stack == []
