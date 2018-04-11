
from Structs import ListNode
"""
翻转一个链表

"""

class Solution(object):
    def reverseList(self, head:ListNode) -> ListNode:
        prev = None
        while head:
            """
            使用一个空的链表对象，保存当前和下一个节点的位置
            然后每次将顺序逆转，重新指向
            """
            cur = head
            head = cur.next
            cur.next = prev
            prev = cur
        return prev
        pass
