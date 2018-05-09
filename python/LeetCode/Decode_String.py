"""
字符串解码

给定一个经过编码的字符串，返回它解码的字符串

编码规格k[string]，将方括号内部的string重复k次数

"""

class Solution(object):
    def decodeString(self, s):
        k, str_stack, num_stack = 0, [], []
        for i in range(len(s)):
            lef: str = s[i]
            if lef.isdigit():
                k = int(lef)
            elif lef == '[':
                num_stack.append(k)
                str_stack.append(lef)
                k = 0
            elif lef.isalpha():
                str_stack.append(lef)
            elif lef == ']': # 可以入栈操作了
                tmp = ""
                while str_stack and str_stack[-1] != '[':
                    tmp = str_stack.pop() + tmp
                str_stack.pop()
                tmp = tmp * num_stack.pop()
                str_stack.append(tmp)
                print(str_stack)
        return "".join(str_stack)


if __name__ == '__main__':
    s = Solution()
    content = "3[a]2[bc]"
    result = s.decodeString(content)
    print(result)