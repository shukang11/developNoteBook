
from Structs import TreeNode

"""
给定一个二叉树结构，返回一个二叉树的中序遍历

"""

"""
那么，什么是中序遍历

前序遍历：根节点->左子树->右子树

中序遍历：左子树->根节点->右子树

后序遍历：左子树->右子树->根节点

"""


class Solution:

    def inorderTraversal(self,root):
        res = []
        self.helper(root, res)
        return res

    def helper(self, root, res):
        if not root:
            return None
        self.helper(root.left, res)
        res.append(root.val)
        self.helper(root.right, res)
