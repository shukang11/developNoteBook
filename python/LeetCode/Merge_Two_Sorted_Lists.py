from Structs import ListNode

"""
合并两个链表，
e.g:
Input: 1->2->4, 1->3->4
Output: 1->1->2->3->4->4

思路：值传递，递归
"""
class Solution(object):

    def mergeTwoLists(self, l1: ListNode, l2: ListNode) -> ListNode:
        # is 用来判断a，b对象是否就是一个对象；
        # == 判断a，b两个对象的值是否相等，是通过其value来判断的
        if l1 is None and l2 is None:
            return None
        mergeNode = None
        if l1.val < l2.val:
            mergeNode = l1
            mergeNode.next = self.mergeTwoLists(l1.next, l2)
        else:
            mergeNode = l2
            mergeNode.next = self.mergeTwoLists(l1, l2.next)
        return mergeNode