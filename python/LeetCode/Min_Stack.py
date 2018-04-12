"""
最小栈

设计一个栈结构， 支持以下操作

push(x) -- Push element x onto stack.
pop() -- Removes the element on top of the stack.
top() -- Get the top element.
getMin() -- Retrieve the minimum element in the stack.
"""
class MinStack(object):

    def __init__(self):
        self.stack = []

    def push(self, x):
        #self.stack.append(x)
        self.stack.append((x, min(self.getMin(), x)))

    def pop(self):
        self.stack.pop()

    def top(self):
        if self.stack:
            return self.stack[-1][0]
        # sortStack = sorted(self.stack)
        # return sortStack.pop()

    def getMin(self):
        if self.stack:
            return self.stack[-1][1]
        import sys
        return sys.maxsize
        # sortStack = sorted(self.stack, reverse=True)
        # return sortStack.pop()