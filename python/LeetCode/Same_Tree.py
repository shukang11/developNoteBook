
from Structs import TreeNode

"""
给定两个树状结构，判断两个树是否相等
"""

class Solution:
    def isSameTree(self, p: TreeNode, q:TreeNode):
        return self.dfsRec(p, q)

    def dfsRec(self, r1: TreeNode, r2: TreeNode):
        if not r1 and not r2: return True
        elif not r1 or not r2 or r1.val != r2.val: return False
        return self.dfsRec(r1.left, r2.left) and self.dfsRec(r1.right, r2.right)