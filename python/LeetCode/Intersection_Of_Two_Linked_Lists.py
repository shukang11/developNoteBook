from Structs import ListNode
"""
相交链表

找到两个单链表相交的起始节点。

例如，下面的两个链表：

A:          a1 → a2
                   ↘
                     c1 → c2 → c3
                   ↗            
B:     b1 → b2 → b3
在节点 c1 开始相交。

注意：

如果两个链表没有交点，返回 null.
在返回结果后，两个链表仍须保持原有的结构。
可假定整个链表结构中没有循环。
程序尽量满足 O(n) 时间复杂度，且仅用 O(1) 内存。


如果两个链表有相交点，将两个链表拼起来循环一下，一定会有相交的点
"""

class Solution(object):
    def getIntersesctionNode(self, headA, headB):
        if not headA or not headB:
            return None
        pa, pb = headA, headB
        while pa is not pb:
            pa = headB if not pa else pa.next
            pb = headA if not pb else pb.next
        return pa