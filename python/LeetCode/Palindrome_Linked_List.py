from Structs import ListNode

"""
回文链表

从前往后读和从后往前读是一样的

"""

class Solution(object):
    def isPalindrome(self, head):
        fast, slow = head
        while fast and fast.next:
            fast = fast.next.next
            slow = slow.next # At middle
        node = None
        while slow: # 将slow反转
            nxt = slow.next
            slow.next = node
            node = slow
            slow = nxt
        while node:
            if node.val != head.val:
                return False
            node = node.next
            head = head.next
        return True
    pass