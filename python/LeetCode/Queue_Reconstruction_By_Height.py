"""
假设有随机的人群站成队列，每个人被[h, k]描述， h表示高度，k表示站在他前面并且身高超过或等于他的人的数量

请写出一个符合要求的队列
e.g:
Input:
[[7,0], [4,4], [7,1], [5,0], [6,1], [5,2]]

Output:
[[5,0], [7,0], [5,2], [6,1], [4,4], [7,1]]

思路：
首先按照身高排序好，高的在前面

为什么根据第二个数值就可以确定插入位置呢？

首先是身高由高到低，插入的时候就可以保证前面的都是比自己高的，在根据第二个插入就比较巧妙了
"""

class Solution(object):

    def reconstructQueue(self, people:[[int]]) -> [[int]]:
        if not people:
             return []
        sortedQueue = sorted(people, key=lambda x: x[0], reverse=True)
        print(sortedQueue)
        # [[7, 0], [7, 1], [6, 1], [5, 0], [5, 2], [4, 4]]
        res = []
        for p in sortedQueue:
            res.insert(p[1], p)
        return res


if __name__ == '__main__':
    s = Solution()
    people = [[7,0], [4,4], [7,1], [5,0], [6,1], [5,2]]
    re = s.reconstructQueue(people)
    print(re)
