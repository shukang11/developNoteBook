"""
任务调度器

给定一个用字符组成的表示cpu需要执行的任务列表，其中包含使用A-Z表示不同种类的任务，任务可以以任意顺序执行，并且每个任务都可以在1个单位时间内完成，cpu在任何一个单位时间内都可以执行一个任务，或者在待命状态
两个相同种类的任务必须有长度为n的冷却时间，因此至少有连续n个单位时间内cpu在执行不同的任务，或者在待命状态

计算完成所有任务所需要的最短时间

输入: tasks = ["A","A","A","B","B","B"], n = 2
输出: 8
执行顺序: A -> B -> (待命) -> A -> B -> (待命) -> A -> B.

思路：
AAAABBBEEFFGG 3

我们发现任务A出现了4次，频率最高，于是我们在每个A中间加入三个空位，如下：

A---A---A---A

AB--AB--AB--A   (加入B)

ABE-ABE-AB--A   (加入E)

ABEFABE-ABF-A   (加入F，每次尽可能填满或者是均匀填充)

ABEFABEGABFGA   (加入G)
"""

class Solution(object):
    def leastInterval(self, tasks, n):
        helper = [0]*26
        for x in tasks:
            helper[ord(x) - 65] += 1
        helper.sort(reverse=True)
        ans = helper[0]*(n+1)-n # ?
        for i in range(1, len(helper)):
            if helper[i] == helper[0]:
                ans += 1
            else:
                break
        return max(ans, sum(helper))


if __name__ == '__main__':
    s= Solution()
    tasks = ["A","A","A","B","B","B"]
    n = 2
    result = s.leastInterval(tasks=tasks, n=n)
    print(result)