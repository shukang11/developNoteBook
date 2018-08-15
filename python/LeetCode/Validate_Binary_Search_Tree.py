
from Structs import TreeNode
"""
给定一个二叉树，判断是否是一个合规的二叉树(BST)

左子树小于根节点
右子树大于根节点
左右子树都必须有值

"""

class Solution:
    def isValidBST(self, root):
        self.arr = []
        self.inorder(root)
        return self.arr == sorted(self.arr) and len(self.arr) == len(set(self.arr))

    def inorder(self, root):
        if not root: return
        if root.left: self.inorder(root.left)
        self.arr.append(root.val)
        if root.right: self.inorder(root.right)