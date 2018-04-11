from Structs import TreeNode
"""
合并两个二叉树

相同位置做求和

思路： 递归方式
"""
class Solution(object):

    def mergeTrees(self, t1: TreeNode, t2: TreeNode):
        if t1 is None and t2 is None: return None
        if t1 is None:return t2
        if t2 is None: return t1
        node = TreeNode(t1.val + t2.val)
        node.left = self.mergeTrees(t1.left, t2.left)
        node.right = self.mergeTrees(t1.right, t2.right)
        return node