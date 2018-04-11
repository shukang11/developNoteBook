from Structs import ListNode

class Solution:
    """
    判断一个链表结构是否有环
     思路： 设置两个指针，一快一慢，
     如果这个链表有环的话那么指针一定会走到同一处

     如果遍历到了最后都没有遇到，说明结构无环

    """
    def hasCycle(self, head) -> bool:
        if head is None: return False
        slow, fast = head, head
        while fast is not None \
                and fast.next is not None:
            slow = slow.next
            fast = fast.next.next
            if slow is fast: return True
        return False