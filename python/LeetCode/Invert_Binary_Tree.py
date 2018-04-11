from Structs import TreeNode
"""
翻转一个二叉树

还是递归思路：
子节点的左右子节点对调，如此往复
"""

class Solution(object):

    def invertTree(self, root: TreeNode):
        if root is None:
            return None
        tmNode = root.left
        root.left = self.invertTree(root.right)
        root.right = self.invertTree(tmNode)
